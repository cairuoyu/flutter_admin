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
import 'package:cry/form/cry_input.dart';
import 'package:cry/model/order_item_model.dart';
import 'package:cry/model/page_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/dict_api.dart';
import 'package:cry/cry_button.dart';
import 'package:flutter_admin/constants/constant_dict.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/dict.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/pages/dict/dict_edit.dart';
import 'package:cry/utils/cry_utils.dart';
import 'package:flutter_admin/utils/dict_util.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:dio/dio.dart';

class DictList extends StatefulWidget {
  DictList({Key? key}) : super(key: key);

  @override
  _DictList createState() => _DictList();
}

class _DictList extends State<DictList> {
  PageModel page = PageModel(orders: [OrderItemModel(column: 'create_time')]);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<CryDataTableState> tableKey = GlobalKey<CryDataTableState>();
  Dict dict = Dict();

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
            value: dict.code,
            onSaved: (v) {
              dict.code = v;
            },
          ),
          CryInput(
            label: S.of(context).name,
            width: 400,
            value: dict.name,
            onSaved: (v) {
              dict.name = v;
            },
          ),
        ],
      ),
    );
    List<Dict> selectedList = tableKey.currentState?.getSelectedList(page).map<Dict>((e) => Dict.fromMap(e)).toList() ?? [];
    var buttonBar = CryButtonBar(
      children: [
        CryButtons.query(context, () => _query()),
        CryButtons.reset(context, () => _reset()),
        CryButtons.add(context, () => _edit(null)),
        CryButtons.delete(context, selectedList.isEmpty ? null : () => _delete(selectedList)),
        CryButton(iconData: Icons.file_download, label: S.of(context).downloadTemplate, onPressed: _downloadTemplate),
        CryButton(iconData: Icons.redo, label: S.of(context).importExcel, onPressed: _importExcel),
        CryButton(iconData: Icons.reply, label: S.of(context).exportExcel, onPressed: _exportExcel),
      ],
    );
    var table = Expanded(
      child: SingleChildScrollView(
        child: CryDataTable(
          key: tableKey,
          title: S.of(context).dictList,
          onPageChanged: (firstRowIndex) {
            page.current = (firstRowIndex ~/ page.size + 1);
            _loadData();
          },
          onRowsPerPageChanged: (int size) {
            page.size = size;
            page.current = 1;
            _loadData();
          },
          selectable: (m) {
            return Dict.fromMap(m).state != ConstantDict.CODE_YESNO_YES;
          },
          onSelectChanged: (v) {
            this.setState(() {});
          },
          columns: [
            DataColumn(label: Text(S.of(context).operating)),
            DataColumn(label: Text(S.of(context).code)),
            DataColumn(label: Text(S.of(context).name)),
            DataColumn(label: Text(S.of(context).enable)),
          ],
          getCells: (m) {
            Dict dict = Dict.fromMap(m);
            return [
              DataCell(CryButtonBar(
                children: dict.state == ConstantDict.CODE_YESNO_YES ? [] : [CryButton(iconData: Icons.edit, onPressed: () => _edit(dict))],
              )),
              DataCell(Text(dict.code!)),
              DataCell(Text(dict.name!)),
              DataCell(Text(
                DictUtil.getDictItemName(dict.state, ConstantDict.CODE_YESNO)!,
                style: dict.state == ConstantDict.CODE_YESNO_YES ? TextStyle(color: Colors.red) : null,
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

  _downloadTemplate() {
    Utils.launchURL("http://www.cairuoyu.com/f/template/template_dict.xlsx");
  }

  _importExcel() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xlsx']);

    if (result == null) {
      return;
    }
    var bytes = result.files.first.bytes!;
    String? filename = result.files.first.name;
    MultipartFile file = MultipartFile.fromBytes(bytes, filename: filename);
    var data = FormData.fromMap({'file': file});
    await DictApi.importExcel(data);
    this._loadData();
    CryUtils.message(S.of(context).success);
  }

  _exportExcel() async {
    ResponseBodyApi responseBodyApi = await DictApi.exportExcel(RequestBodyApi(page: page, params: this.dict.toMap()).toMap());
    if (!responseBodyApi.success!) {
      return;
    }
    var downloadUrl = responseBodyApi.data;
    Utils.launchURL(downloadUrl);
  }

  _query() {
    this.formKey.currentState?.save();
    this._loadData();
  }

  _reset() {
    this.dict = Dict();
    this._loadData();
  }

  _delete(List<Dict> dictList) {
    cryConfirm(context, S.of(context).confirmDelete, (context) async {
      var result = await DictApi.removeByIds(dictList.map((e) => e.id).toList());
      if (result.success) {
        this._loadData();
        CryUtils.message(S.of(context).success);
      }
    });
  }

  _edit(Dict? dict) async {
    var result = await Utils.fullscreenDialog(DictEdit(dict: dict));
    if (result ?? false) {
      this._loadData();
    }
  }

  _loadData() async {
    ResponseBodyApi responseBodyApi = await DictApi.page(RequestBodyApi(page: page, params: this.dict.toMap()).toMap());
    page = PageModel.fromMap(responseBodyApi.data);
    setState(() {
      tableKey.currentState!.loadData(page);
    });
  }
}
