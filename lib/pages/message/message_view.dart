import 'package:flutter/material.dart';
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
    var body = Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.message.title,
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.black54,
                  fontSize: 30,
                ),
          ),
          Divider(thickness: 2),
          Text(widget.message.content),
        ],
      ),
    );
    var result = Scaffold(
      appBar: AppBar(
        title: Text('查看'),
      ),
      body: SingleChildScrollView(child: body),
    );
    return Theme(
      data: Utils.getThemeData(context),
      child: result,
    );
  }
}
