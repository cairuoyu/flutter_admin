import 'package:cry/form/cry_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_admin/api/dict_item_api.dart';
import 'package:cry/cry_button.dart';
import 'package:flutter_admin/models/dict.dart';
import 'package:flutter_admin/models/dict_item.dart';
import 'package:flutter_admin/models/response_body_api.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:quiver/strings.dart';

class DictItemListEdit extends StatefulWidget {
  DictItemListEdit(
    this.dict, {
    Key key,
    this.onSave,
  }) : super(key: key);

  final Dict dict;
  final Function onSave;

  @override
  DictItemListEditState createState() => DictItemListEditState();
}

class DictItemListEditState extends State<DictItemListEdit> {
  final GlobalKey<FormState> tableFormKey = GlobalKey<FormState>();
  List<DictItem> dictItemList = [];

  @override
  void initState() {
    super.initState();
    this.init();
  }

  init() async {
    ResponseBodyApi responseBodyApi = await DictItemApi.list(DictItem(dictId: widget.dict.id).toMap());
    this.dictItemList = List.from(responseBodyApi.data).map((e) => DictItem.fromMap(e)).toList();
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
      rows: this.dictItemList.map((dictItem) {
        int rowIndex = i + 1;
        var result = DataRow(
          cells: [
            DataCell(Text((rowIndex).toString())),
            DataCell(ButtonBar(
              children: [
                CryButton(
                  iconData: Icons.delete,
                  onPressed: () => _delete(dictItem),
                ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buttonBar,
        tableForm,
      ],
    );
  }

  _add() {
    this.tableFormKey.currentState.save();
    this.dictItemList.add(DictItem(dictId: widget.dict.id));
    this.setState(() {});
  }

  _delete(dictItem) {
    this.tableFormKey.currentState.save();
    this.dictItemList.remove(dictItem);
    this.setState(() {});
  }

  validate() {
    this.tableFormKey.currentState.save();
    if (this.dictItemList.firstWhere((element) => isEmpty(element.name) || isEmpty(element.code), orElse: () {
          return null;
        }) !=
        null) {
      Utils.message('请完善表格数据');
      return false;
    }
    return true;
  }

  List<DictItem> save() {
    widget.onSave(this.dictItemList);
  }
}
