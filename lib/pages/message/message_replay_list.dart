/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_list_view.dart';
import 'package:cry/model/order_item_model.dart';
import 'package:cry/model/page_model.dart';
import 'package:flutter/material.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/api/message_api.dart';
import 'package:flutter_admin/models/message.dart';
import 'package:flutter_admin/models/message_replay_model.dart';

class MessageReplayList extends StatefulWidget {
  final String? messageId;

  const MessageReplayList({Key? key, this.messageId}) : super(key: key);

  @override
  MessageReplayListState createState() => MessageReplayListState();
}

class MessageReplayListState extends State<MessageReplayList> {
  List<MessageReplayModel> messageReplayModelList = [];
  PageModel page = PageModel(size: 30, orders: [OrderItemModel(column: 'create_time', asc: false)]);
  bool anyMore = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (messageReplayModelList.isEmpty) {
      return Container();
    }
    var listView = CryListView(
      count: messageReplayModelList.length,
      getCell: (index) {
        MessageReplayModel messageReplayModel = messageReplayModelList[index];
        return ListTile(
          leading: messageReplayModel.avatarUrl == null
              ? Icon(Icons.person)
              : CircleAvatar(
                  backgroundImage: NetworkImage(messageReplayModel.avatarUrl!),
                  radius: 12.0,
                ),
          title: Text(messageReplayModel.content!),
          trailing: Text(messageReplayModel.createTime ?? '--'),
        );
      },
      loadMore: loadMore,
      onRefresh: reloadData,
    );
    return Card(
      child: listView,
      color: Colors.black54,
      shadowColor: Colors.red,
    );
  }

  Future reloadData() async {
    page.current = 1;
    messageReplayModelList = [];
    anyMore = true;
    await loadData();
  }

  loadMore() {
    if (!anyMore) {
      return;
    }
    page.current = page.current + 1;
    loadData();
  }

  loadData() async {
    RequestBodyApi requestBodyApi = RequestBodyApi(page: page, params: Message(id: widget.messageId).toMap());
    ResponseBodyApi responseBodyApi = await MessageApi.replayPage(requestBodyApi.toMap());
    page = PageModel.fromMap(responseBodyApi.data);
    messageReplayModelList = [...messageReplayModelList, ...page.records.map((e) => MessageReplayModel.fromMap(e)).toList()];
    if (page.current == page.pages) {
      anyMore = false;
    }
    this.setState(() {});
  }
}
