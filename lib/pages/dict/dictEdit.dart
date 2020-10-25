import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_admin/api/dictApi.dart';
import 'package:flutter_admin/api/dictItemApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/form2/cryInput.dart';
import 'package:flutter_admin/models/dict.dart';
import 'package:flutter_admin/models/dictItem.dart';
import 'package:flutter_admin/models/responseBodyApi.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:quiver/strings.dart';

class DictEdit extends StatefulWidget {
  final Dict dict;

  DictEdit({this.dict});

  @override
  _DictEditState createState() => _DictEditState();
}

class _DictEditState extends State<DictEdit> {
  Dict dict;
  List<DictItem> dictItemList = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> tableFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    dict = widget.dict ?? Dict();
    ResponseBodyApi responseBodyApi = await DictItemApi.list(DictItem(dictId: dict.id).toMap());
    dictItemList = List.from(responseBodyApi.data).map((e) => DictItem.fromMap(e)).toList();
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Wrap(
        children: [
          CryInput(
            label: '字典代码',
            value: dict.code,
            width: 400,
            required: true,
            onSaved: (v) {
              this.dict.code = v;
            },
          ),
          CryInput(
            label: '字典名称',
            value: dict.name,
            width: 400,
            required: true,
            onSaved: (v) {
              this.dict.name = v;
            },
          )
        ],
      ),
    );
    var buttonBar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        CryButton(
          label: '增加一行',
          iconData: Icons.add,
          onPressed: () => this._add(),
        )
      ],
    );
    int i = 0;
    var table = DataTable(
      columns: [
        DataColumn(label: Text('#')),
        DataColumn(label: Text('操作')),
        DataColumn(label: Text('字典项代码')),
        DataColumn(label: Text('字典项名称')),
      ],
      rows: this.dictItemList.map((e) {
        DictItem dictItem = this.dictItemList[i];
        int rowIndex = i + 1;
        var result = DataRow(
          cells: [
            DataCell(Text((rowIndex).toString())),
            DataCell(ButtonBar(
              children: [
                CryButton(
                    iconData: Icons.delete,
                    onPressed: () {
                      this.dictItemList.remove(e);
                      this.setState(() {});
                    }),
              ],
            )),
            DataCell(CryInput(
              width: 200,
              padding: 0,
              contentPadding: 0,
              value: dictItem.code,
              onSaved: (v) {
                dictItem.code = v;
              },
            )),
            DataCell(CryInput(
              width: 200,
              padding: 0,
              contentPadding: 0,
              value: dictItem.name,
              onSaved: (v) {
                dictItem.name = v;
              },
            )),
          ],
        );
        i++;
        return result;
      }).toList(),
    );
    var tableForm = Form(
      key: tableFormKey,
      child: table,
    );
    var result = Scaffold(
      appBar: AppBar(
        actions: [
          CryButton(
            iconData: Icons.save,
            onPressed: () => _save(),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          form,
          buttonBar,
          tableForm,
        ],
      ),
    );
    return Theme(
      data: Utils.getThemeData(context),
      child: result,
    );
  }

  _add() {
    this.tableFormKey.currentState.save();
    this.dictItemList.add(DictItem(dictId: dict.id));
    this.setState(() {});
  }

  _save() async {
    this.tableFormKey.currentState.save();
    if (this.dictItemList.firstWhere((element) => isEmpty(element.name) || isEmpty(element.code), orElse: () {
          return null;
        }) !=
        null) {
      Utils.message('请完善表格数据');
      return;
    }
    this.formKey.currentState.save();
    if (!this.formKey.currentState.validate()) {
      return;
    }

    var dict = this.dict.toMap();
    var dictItemList = this.dictItemList.map((e) => e.toMap()).toList();
    var params = {"dict": dict, "dictItemList": dictItemList};

    ResponseBodyApi res = await DictApi.saveOrUpdate(params);
    if (!res.success) {
      return;
    }
    Navigator.pop(context);
  }
}
