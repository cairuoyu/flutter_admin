/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_buttons.dart';
import 'package:cry/form/cry_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_admin/api/dict_api.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/dict.dart';
import 'package:flutter_admin/models/dict_item.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/pages/dict/dict_item_list_edit.dart';
import 'package:cry/utils/cry_utils.dart';

class DictEdit extends StatefulWidget {
  final Dict? dict;

  DictEdit({this.dict});

  @override
  _DictEditState createState() => _DictEditState();
}

class _DictEditState extends State<DictEdit> {
  Dict? dict;
  List<DictItem> dictItemList = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<DictItemListEditState> dictItemListEditKey = GlobalKey<DictItemListEditState>();

  @override
  void initState() {
    super.initState();
    dict = widget.dict ?? Dict();
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Wrap(
        children: [
          CryInput(
            label: S.of(context).code,
            value: dict!.code,
            width: 400,
            required: true,
            onSaved: (v) {
              this.dict!.code = v;
            },
          ),
          CryInput(
            label: S.of(context).name,
            value: dict!.name,
            width: 400,
            required: true,
            onSaved: (v) {
              this.dict!.name = v;
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
        actions: [CryButtons.save(context, () => _save())],
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
    return result;
  }

  _save() async {
    if (!this.formKey.currentState!.validate()) {
      return;
    }
    if (!this.dictItemListEditKey.currentState!.validate()) {
      return;
    }
    this.formKey.currentState!.save();
    this.dictItemListEditKey.currentState!.save();

    var dict = this.dict!.toMap();
    var dictItemList = this.dictItemList.map((e) => e.toMap()).toList();
    var params = {"dict": dict, "dictItemList": dictItemList};

    ResponseBodyApi res = await DictApi.saveOrUpdate(params);
    if (!res.success!) {
      return;
    }
    Navigator.pop(context, true);
    CryUtils.message(S.of(context).success);
  }
}
