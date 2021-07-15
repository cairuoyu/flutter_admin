/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_button_bar.dart';
import 'package:cry/cry_buttons.dart';
import 'package:cry/cry_data_table.dart';
import 'package:cry/cry_dialog.dart';
import 'package:cry/form/cry_checkbox.dart';
import 'package:cry/form/cry_input.dart';
import 'package:cry/model/order_item_model.dart';
import 'package:cry/model/page_model.dart';
import 'package:cry/utils/cry_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/subsystem_api.dart';
import 'package:flutter_admin/constants/constant_dict.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/subsystem.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/models/subsystem_vo.dart';
import 'package:flutter_admin/pages/subsystem/subsystem_edit.dart';
import 'package:flutter_admin/utils/utils.dart';

class SubsystemMain extends StatefulWidget {
  SubsystemMain({Key? key}) : super(key: key);

  @override
  _SubsystemMain createState() => _SubsystemMain();
}

class _SubsystemMain extends State<SubsystemMain> {
  PageModel page = PageModel(orders: [OrderItemModel(column: 'create_time')]);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<CryDataTableState> tableKey = GlobalKey<CryDataTableState>();
  SubsystemVO subsystemVO = SubsystemVO();

  @override
  void initState() {
    super.initState();
    this._query();
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Wrap(
        children: [
          CryInput(
            label: S.of(context).code,
            width: 400,
            value: subsystemVO.code,
            onSaved: (v) {
              subsystemVO.code = v;
            },
          ),
          CryInput(
            label: S.of(context).name,
            width: 400,
            value: subsystemVO.name,
            onSaved: (v) {
              subsystemVO.name = v;
            },
          ),
          Wrap(
            children: [
              CryCheckbox(S.of(context).enable, subsystemVO.isEnable!, (v) {
                this.subsystemVO.isEnable = v;
              }),
              CryCheckbox(S.of(context).disable, subsystemVO.isDisable!, (v) => this.subsystemVO.isDisable = v),
            ],
          ),
        ],
      ),
    );
    List<Subsystem> selectedList = tableKey.currentState?.getSelectedList(page).map<Subsystem>((e) => Subsystem.fromMap(e)).toList() ?? [];
    var buttonBar = CryButtonBar(
      children: [
        CryButtons.query(context, () => _query()),
        CryButtons.reset(context, () => _reset()),
        CryButtons.add(context, () => _edit(null)),
        CryButtons.edit(context, selectedList.length != 1 ? null : () => _edit(selectedList[0])),
        CryButtons.delete(context, selectedList.isEmpty ? null : () => _delete(selectedList)),
      ],
    );
    var table = Expanded(
      child: SingleChildScrollView(
        child: CryDataTable(
          key: tableKey,
          title: S.of(context).subsystemList,
          onPageChanged: (firstRowIndex) {
            page.current = (firstRowIndex ~/ page.size + 1);
            _loadData();
          },
          onRowsPerPageChanged: (int size) {
            page.size = size;
            page.current = 1;
            _loadData();
          },
          onSelectChanged: (v) {
            this.setState(() {});
          },
          columns: [
            DataColumn(label: Text(S.of(context).code)),
            DataColumn(label: Text(S.of(context).name)),
            DataColumn(label: Text('URL')),
            DataColumn(label: Text(S.of(context).sequenceNumber)),
            DataColumn(label: Text(S.of(context).remarks)),
            DataColumn(label: Text(S.of(context).enable)),
            DataColumn(label: Text(S.of(context).operating)),
          ],
          getCells: (m) {
            Subsystem subsystem = Subsystem.fromMap(m);
            return [
              DataCell(Text(subsystem.code ?? '--')),
              DataCell(Text(subsystem.name ?? '--')),
              DataCell(Text(subsystem.url ?? '--')),
              DataCell(Text(subsystem.orderBy ?? '--')),
              DataCell(Text(subsystem.remark ?? '--')),
              DataCell(Switch(
                  value: subsystem.state == ConstantDict.CODE_YESNO_YES,
                  onChanged: (v) async {
                    subsystem.state = v ? ConstantDict.CODE_YESNO_YES : ConstantDict.CODE_YESNO_NO;
                    await SubsystemApi.saveOrUpdate(subsystem.toMap());
                    _loadData();
                  })),
              DataCell(ButtonBar(
                children: [
                  CryButtons.edit(context, () => _edit(subsystem), showLabel: false),
                  CryButtons.delete(context, () => _delete([subsystem]), showLabel: false),
                ],
              )),
            ];
          },
        ),
      ),
    );
    var result = Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          form,
          buttonBar,
          table,
        ],
      ),
    );
    return result;
  }

  _query() {
    this.formKey.currentState?.save();
    this._loadData();
  }

  _reset() {
    this.subsystemVO = SubsystemVO();
    this._loadData();
  }

  _delete(List<Subsystem> subsystemList) {
    cryConfirm(context, S.of(context).confirmDelete, (context) async {
      ResponseBodyApi responseBodyApi = await SubsystemApi.removeByIds(subsystemList.map((e) => e.id).toList());
      if (!responseBodyApi.success!) {
        return;
      }
      CryUtils.message(S.of(context).success);
      this._loadData();
    });
  }

  _edit(Subsystem? subsystem) async {
    var result = await Utils.fullscreenDialog(SubsystemEdit(subsystem: subsystem));
    if (result ?? false) {
      _loadData();
    }
  }

  _loadData() async {
    ResponseBodyApi responseBodyApi = await SubsystemApi.page(RequestBodyApi(page: page, params: this.subsystemVO.toMap()).toMap());
    page = PageModel.fromMap(responseBodyApi.data);
    setState(() {
      tableKey.currentState!.loadData(page);
    });
  }
}
