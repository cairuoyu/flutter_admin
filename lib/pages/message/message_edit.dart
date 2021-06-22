/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_button_bar.dart';
import 'package:cry/cry_buttons.dart';
import 'package:cry/form/cry_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/message_api.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/message.dart';
import 'package:cry/utils/cry_utils.dart';

class MessageEdit extends StatefulWidget {
  @override
  _MessageEditState createState() => _MessageEditState();
}

class _MessageEditState extends State<MessageEdit> {
  Message _message = Message();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var buttonBar = CryButtonBar(
      children: [
        CryButtons.commit(context, save),
      ],
    );
    var form = Form(
      key: formKey,
      child: Column(
        children: [
          CryInput(
            label: S.of(context).title,
            required: true,
            onSaved: (v) {
              this._message.title = v;
            },
          ),
          CryInput(
            label: S.of(context).content,
            required: true,
            maxLines: 12,
            onSaved: (v) {
              this._message.content = v;
            },
          ),
        ],
      ),
    );
    var result = SingleChildScrollView(
      child: Column(
        children: [
          form,
          buttonBar,
        ],
      ),
    );
    return result;
  }

  save() async {
    if (!this.formKey.currentState!.validate()) {
      return;
    }
    this.formKey.currentState!.save();
    await MessageApi.save(this._message.toMap());
    CryUtils.message(S.of(context).success);
    this.setState(() {});
  }
}
