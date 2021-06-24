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
import 'package:flutter_admin/models/message_replay_model.dart';
import 'package:cry/utils/cry_utils.dart';

class MessageReplay extends StatefulWidget {
  final Message? message;

  const MessageReplay({Key? key, this.message}) : super(key: key);

  @override
  _MessageReplayState createState() => _MessageReplayState();
}

class _MessageReplayState extends State<MessageReplay> {
  GlobalKey<FormState> formKey = GlobalKey();
  MessageReplayModel messageReplayModel = MessageReplayModel();

  @override
  void initState() {
    messageReplayModel.messageId = widget.message!.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Column(
        children: [
          CryInput(
            maxLines: 10,
            required: true,
            onSaved: (v) {
              messageReplayModel.content = v;
            },
          ),
        ],
      ),
    );
    var buttonBar = CryButtonBar(
      children: [
        CryButtons.commit(context, commit),
        CryButtons.cancel(context, () => Navigator.pop(context)),
      ],
    );
    var result = Scaffold(
      appBar: AppBar(title: Text(S.of(context).replay + '-' + widget.message!.title!)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            form,
            buttonBar,
          ],
        ),
      ),
    );
    return result;
  }

  commit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    var result = await MessageApi.replayCommit(messageReplayModel.toMap());
    if (result.success!) {
      Navigator.pop(context);
      CryUtils.message(S.of(context).success);
    }
  }
}
