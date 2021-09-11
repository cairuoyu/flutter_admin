/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/9/3
/// @version: 1.0
/// @description: 

import 'package:cry/cry.dart';
import 'package:cry/cry_all.dart';
import 'package:cry/utils/cry_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/setting_default_tab.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/tab_page.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SettingDefaultTab extends StatefulWidget {
  @override
  _SettingDefaultTabState createState() => _SettingDefaultTabState();
}

class _SettingDefaultTabState extends State<SettingDefaultTab> {
  _DataSource ds = _DataSource();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TabPage tabPage = TabPage();

  @override
  void initState() {
    ds.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dataGrid = SfDataGrid(
      source: ds,
      columnWidthMode: ColumnWidthMode.fill,
      columns: <GridColumn>[
        GridColumn(
          columnName: 'name',
          label: Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              "name",
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'nameEn',
          label: Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              "nameEn",
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'url',
          label: Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              "url",
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'operation',
          label: Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: Text(
              S.of(context).operating,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          width: 60,
        ),
      ],
    );
    var rowEdit = Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CryInput(
            label: 'name',
            required: true,
            onSaved: (v) {
              tabPage.name = v;
            },
          ),
          CryInput(
            label: 'nameEn',
            required: true,
            onSaved: (v) {
              tabPage.nameEn = v;
            },
          ),
          CryInput(
            label: 'url',
            required: true,
            onSaved: (v) {
              tabPage.url = v;
            },
          ),
          ButtonBar(
            children: [
              CryButtons.add(context, () async {
                if (!formKey.currentState!.validate()) {
                  return;
                }
                formKey.currentState!.save();
                var res = await SettingDefaultTabApi.saveOrUpdate(tabPage.toMap());
                if (!res.success!) {
                  return;
                }
                CryUtils.message(S.of(context).success);
                tabPage = TabPage();
                setState(() {});
                ds.loadData();
              }),
            ],
          ),
        ],
      ),
    );

    var result = Column(
      children: [
        rowEdit,
        Divider(thickness: 2),
        dataGrid,
      ],
    );
    return result;
  }
}

class _DataSource extends DataGridSource {
  List<DataGridRow> _rows = [];

  loadData() async {
    var responseBodyApi = await SettingDefaultTabApi.list();
    List<TabPage> list = responseBodyApi.data.map<TabPage>((element) => TabPage.fromMap(element)).toList();
    _rows = list.map<DataGridRow>((v) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'vo', value: v),
      ]);
    }).toList(growable: false);
    notifyDataSourceListeners();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    TabPage tabPage = row.getCells()[0].value;
    return DataGridRowAdapter(cells: [
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.centerLeft,
        child: Text(
          tabPage.name!,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.centerLeft,
        child: Text(
          tabPage.nameEn!,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.centerLeft,
        child: Text(
          tabPage.url ?? '--',
        ),
      ),
      CryButtonBar(
        children: [
          CryButtons.delete(Cry.context, () => delete([tabPage.id!]), showLabel: false),
        ],
      ),
    ]);
  }

  delete(List<String> ids) async {
    cryConfirm(Cry.context, S.of(Cry.context).confirmDelete, (context) async {
      var res = await SettingDefaultTabApi.removeByIds(ids);
      if (!res.success) {
        return;
      }
      CryUtils.message(S.of(Cry.context).success);
      loadData();
    });
  }

  @override
  List<DataGridRow> get rows => _rows;
}
