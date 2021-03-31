import 'package:cry/cry_button.dart';
import 'package:cry/cry_list_view.dart';
import 'package:cry/model/order_item_model.dart';
import 'package:cry/model/page_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/message_api.dart';
import 'package:flutter_admin/models/message.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/pages/message/message_replay.dart';
import 'package:flutter_admin/pages/message/message_view.dart';
import 'package:get/get.dart';

class MessageList extends StatefulWidget {
  @override
  MessageListState createState() => MessageListState();
}

class MessageListState extends State<MessageList> {
  List<Message> messageList = [];
  Message message = Message();
  PageModel page = PageModel(orders: [OrderItemModel(column: 'create_time', asc: false)]);
  bool anyMore = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (messageList.isEmpty) {
      return Container();
    }
    var listView = CryListView(
      count: messageList.length,
      getCell: (index) {
        Message message = messageList[index];
        return ListTile(
            onTap: () => Get.to(MessageView(message: message)),
            leading: Text((index + 1).toString()),
            title: Text(message.title),
            subtitle: Text(message.content),
            trailing: CryButton(
              iconData: Icons.replay,
              onPressed: () => Get.to(MessageReplay(message: message)),
            ));
      },
      loadMore: loadMore,
      onRefresh: reloadData,
    );
    return listView;
  }

  Future reloadData() async {
    page.current = 1;
    messageList = [];
    anyMore = true;
    await loadData();
  }

  loadMore() {
    if (!anyMore) {
      return;
    }
    page.current++;
    loadData();
  }

  loadData() async {
    RequestBodyApi requestBodyApi = RequestBodyApi(page: page);
    ResponseBodyApi responseBodyApi = await MessageApi.page(requestBodyApi.toMap());
    page = PageModel.fromMap(responseBodyApi.data);
    messageList = [...messageList, ...page.records.map((e) => Message.fromMap(e)).toList()];
    if (page.current == page.pages) {
      anyMore = false;
    }
    this.setState(() {});
  }
}
