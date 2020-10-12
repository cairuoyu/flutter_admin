import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_admin/api/dictApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/form2/cryInput.dart';
import 'package:flutter_admin/models/dict.dart';
import 'package:flutter_admin/models/responseBodyApi.dart';

class DictEdit extends StatefulWidget {
  final Dict dict;

  DictEdit({this.dict});

  @override
  _DictEditState createState() => _DictEditState();
}

class _DictEditState extends State<DictEdit> {
  Dict dict;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
            label: '字典代码',
            value: dict.code,
            width: 400,
            onSaved: (v) {
              this.dict.code = v;
            },
          ),
          CryInput(
            label: '字典名称',
            value: dict.name,
            width: 400,
            onSaved: (v) {
              this.dict.name = v;
            },
          )
        ],
      ),
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
      body: form,
    );
    return result;
  }

  _save() async {
    this.formKey.currentState.save();
    ResponseBodyApi res = await DictApi.saveOrUpdate(this.dict.toMap());
    if (!res.success) {
      return;
    }
    Navigator.pop(context);
  }
}
