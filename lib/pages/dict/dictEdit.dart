import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_admin/api/dictApi.dart';
import 'package:flutter_admin/api/dictItemApi.dart';
import 'package:cry/cry_button.dart';
import 'package:flutter_admin/components/form2/cryInput.dart';
import 'package:flutter_admin/models/dict.dart';
import 'package:flutter_admin/models/dictItem.dart';
import 'package:flutter_admin/models/responseBodyApi.dart';
import 'package:flutter_admin/pages/dict/dictItemListEdit.dart';
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
  final GlobalKey<DictItemListEditState> dictItemListEditKey = GlobalKey<DictItemListEditState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    dict = widget.dict ?? Dict();
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

    var dictItemListEdit = DictItemListEdit(
      this.dict,
      key: this.dictItemListEditKey,
      onSave: (v) {
        this.dictItemList = v;
      },
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
          Expanded(
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: dictItemListEdit,
              ),
            ),
          ),
        ],
      ),
    );
    return Theme(
      data: Utils.getThemeData(context),
      child: result,
    );
  }

  _save() async {
    if (!this.formKey.currentState.validate()) {
      return;
    }
    if (!this.dictItemListEditKey.currentState.validate()) {
      return;
    }
    this.formKey.currentState.save();
    this.dictItemListEditKey.currentState.save();

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
