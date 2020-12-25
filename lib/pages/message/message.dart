import 'package:cry/cry_toggle_buttons.dart';
import 'package:cry/vo/select_option_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/pages/message/message_edit.dart';

import 'message_list.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  String visibleView = 'add';

  @override
  Widget build(BuildContext context) {
    var toggleButtons = CryToggleButtons(
      [
        SelectOptionVO(value: 'add', label: S.of(context).leaveMessage),
        SelectOptionVO(value: 'list', label: S.of(context).allMessage),
      ],
      defaultValue: 'add',
      afterOnPress: (v) {
        setState(() {
          this.visibleView = v;
        });
      },
    );
    var content;
    if (visibleView == 'add') {
      content = MessageEdit();
    } else {
      content = MessageList();
    }
    return Stack(
      children: [
        toggleButtons,
        Padding(
          child: content,
          padding: EdgeInsets.only(top: 50),
        )
      ],
    );
  }
}
