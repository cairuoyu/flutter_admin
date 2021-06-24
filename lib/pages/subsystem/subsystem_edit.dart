/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry.dart';
import 'package:cry/cry_buttons.dart';
import 'package:cry/form/cry_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/subsystem_api.dart';
import 'package:flutter_admin/constants/constant_dict.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/models/subsystem.dart';
import 'package:cry/utils/cry_utils.dart';

class SubsystemEdit extends StatefulWidget {
  final Subsystem? subsystem;

  SubsystemEdit({Key? key, this.subsystem}) : super(key: key);

  @override
  _SubsystemEditState createState() => _SubsystemEditState();
}

class _SubsystemEditState extends State<SubsystemEdit> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Subsystem _subsystem;

  @override
  void initState() {
    super.initState();
    _subsystem = widget.subsystem ?? Subsystem(state: ConstantDict.CODE_YESNO_YES);
  }

  @override
  Widget build(BuildContext context) {
    var buttonBar = ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        CryButtons.save(context, _save),
        CryButtons.cancel(context, () {
          Navigator.pop(context);
        }),
      ],
    );
    var form = Form(
      key: formKey,
      child: Column(
        children: [
          CryInput(
            value: _subsystem.code,
            label: S.of(context).code,
            onSaved: (v) {
              _subsystem.code = v;
            },
            validator: (v) {
              return v!.isEmpty ? S.of(context).required : null;
            },
          ),
          CryInput(
            value: _subsystem.name,
            label: S.of(context).name,
            onSaved: (v) {
              _subsystem.name = v;
            },
            validator: (v) {
              return v!.isEmpty ? S.of(context).required : null;
            },
          ),
          CryInput(
            value: _subsystem.url,
            label: 'URL',
            onSaved: (v) {
              _subsystem.url = v;
            },
          ),
          CryInput(
            value: _subsystem.orderBy,
            label: S.of(context).sequenceNumber,
            onSaved: (v) {
              _subsystem.orderBy = v;
            },
          ),
          CryInput(
            value: _subsystem.remark,
            label: S.of(context).remarks,
            onSaved: (v) {
              _subsystem.remark = v;
            },
          ),
          SwitchListTile(
            value: _subsystem.state == ConstantDict.CODE_YESNO_YES,
            title: Text(S.of(context).enable),
            onChanged: (v) {
              setState(() {
                formKey.currentState!.save();
                _subsystem.state = v ? ConstantDict.CODE_YESNO_YES : ConstantDict.CODE_YESNO_NO;
              });
            },
          ),
        ],
      ),
    );
    var result = Scaffold(
//      appBar: AppBar(
//        title: Text(widget.subsystem == null ? S.of(context).add : S.of(context).modify),
//      ),
      body: SingleChildScrollView(
        child: Column(
          children: [form],
        ),
      ),
      bottomNavigationBar: buttonBar,
    );
    return SizedBox(
      width: 1500,
      height: 580,
      child: result,
    );
  }

  _save() async {
    var form = formKey.currentState!;
    if (!form.validate()) {
      return;
    }
    form.save();
    ResponseBodyApi responseBodyApi = await SubsystemApi.saveOrUpdate(_subsystem.toMap());
    if (responseBodyApi.success!) {
      Navigator.pop(Cry.context, true);
      CryUtils.message(S.of(context).success);
    }
  }
}
