/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:flutter/material.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/message.dart';
import 'package:flutter_admin/pages/message/message_replay_list.dart';

class MessageView extends StatefulWidget {
  final Message? message;

  const MessageView({Key? key, this.message}) : super(key: key);

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var body = Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.message!.title!,
            style: textTheme.headline3,
          ),
          SizedBox(height: 20),
          Text(
            widget.message!.createTime!,
            style: textTheme.caption,
          ),
          Divider(thickness: 2),
          SizedBox(height: 20),
          Text(widget.message!.content!),
          SizedBox(height: 20),
          Divider(thickness: 2),
          Text(
            'Replay',
            style: textTheme.headline5,
          ),
          Expanded(child: MessageReplayList(messageId: widget.message!.id)),
        ],
      ),
    );
    var result = Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).view),
      ),
      body: body,
      // body: SingleChildScrollView(child: body),
    );
    return result;
  }
}
