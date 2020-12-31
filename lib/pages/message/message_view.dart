import 'package:flutter/material.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/message.dart';
import 'package:flutter_admin/utils/utils.dart';

class MessageView extends StatefulWidget {
  final Message message;

  const MessageView({Key key, this.message}) : super(key: key);

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
            widget.message.title,
            style: textTheme.headline3,
          ),
          SizedBox(height: 20),
          Text(
            widget.message.createTime,
            style: textTheme.caption,
          ),
          Divider(thickness: 2),
          SizedBox(height: 20),
          Text(widget.message.content),
        ],
      ),
    );
    var result = Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).view),
      ),
      body: SingleChildScrollView(child: body),
    );
    return Theme(
      data: Utils.getThemeData(context),
      child: result,
    );
  }
}
