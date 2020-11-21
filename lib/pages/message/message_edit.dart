import 'package:cry/cry_button.dart';
import 'package:cry/form/cry_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/message_api.dart';
import 'package:flutter_admin/models/message.dart';
import 'package:flutter_admin/utils/utils.dart';

class MessageEdit extends StatefulWidget {
  @override
  _MessageEditState createState() => _MessageEditState();
}

class _MessageEditState extends State<MessageEdit> {
  Message _message = Message();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var buttonBar = ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        CryButton(
          label: '提交',
          iconData: Icons.save,
          onPressed: save,
        ),
      ],
    );
    var form = Form(
      key: formKey,
      child: Column(
        children: [
          CryInput(
            label: '标题',
            required: true,
            onSaved: (v) {
              this._message.title = v;
            },
          ),
          CryInput(
            label: '内容',
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
    if (!this.formKey.currentState.validate()) {
      return;
    }
    this.formKey.currentState.save();
    await MessageApi.save(this._message.toMap());
    Utils.message('提交成功');
    this.setState(() {});
  }
}
