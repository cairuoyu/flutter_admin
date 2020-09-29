import 'package:flutter/material.dart';
import 'package:flutter_admin/api/dictApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/cryDataTable.dart';
import 'package:flutter_admin/components/form2/cryInput.dart';
import 'package:flutter_admin/models/dict.dart';
import 'package:flutter_admin/models/page.dart';
import 'package:flutter_admin/models/requestBodyApi.dart';
import 'package:flutter_admin/models/responseBodyApi.dart';

class DictList extends StatefulWidget {
  DictList({Key key}) : super(key: key);

  @override
  _DictList createState() => _DictList();
}

class _DictList extends State<DictList> {
  PageModel page = PageModel();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
            label: '代码',
            width: 400,
            onSaved: (v) {
              dict.code = v;
            },
          ),
          CryInput(
            label: '名称',
            width: 400,
          ),
        ],
      ),
    );
    var buttonBar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        CryButton(
          label: '查询',
          onPressed: _query,
        ),
      ],
    );
    var table = Expanded(
      child: SingleChildScrollView(
        child: CryDataTable(
          title: '数据字典',
          page: page,
          columns: [
            DataColumn(label: Text("代码")),
            DataColumn(label: Text("名称")),
          ],
          getCells: (Map m) {
            Dict dict = Dict.fromMap(m);
            return [
              DataCell(Text(dict.code)),
              DataCell(Text(dict.name)),
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

  _loadData() async {
    ResponseBodyApi responseBodyApi = await DictApi.page(RequestBodyApi(page: page, params: this.dict.toMap()));
    page = PageModel.fromJson(responseBodyApi.data);
    setState(() {});
  }
}
