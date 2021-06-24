/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_button.dart';
import 'package:cry/cry_button_bar.dart';
import 'package:cry/cry_buttons.dart';
import 'package:cry/cry_dialog.dart';
import 'package:cry/cry_list_view.dart';
import 'package:cry/model/order_item_model.dart';
import 'package:cry/model/page_model.dart';
import 'package:cry/utils/cry_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/message_api.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/message.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/pages/message/message_replay.dart';
import 'package:flutter_admin/pages/message/message_view.dart';
import 'package:flutter_admin/utils/utils.dart';

class MessageList extends StatefulWidget {
  @override
  MessageListState createState() => MessageListState();
}

class MessageListState extends State<MessageList> {
  List<Message> messageList = [];
  Message message = Message();
  PageModel page = PageModel(orders: [OrderItemModel(column: 'create_time', asc: false)], size: 50);
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
            onTap: () => Utils.fullscreenDialog(MessageView(message: message)),
            leading: Text((index + 1).toString()),
            title: Text(message.title!),
            subtitle: Text(message.content!),
            trailing: SizedBox(
              width: 110,
              child: CryButtonBar(
                children: [
                  CryButtons.delete(context, () => _delete([message]), showLabel: false),
                  CryButton(
                    iconData: Icons.replay,
                    onPressed: () => Utils.fullscreenDialog(MessageReplay(message: message)),
                  ),
                ],
              ),
            ));
      },
      loadMore: loadMore,
      onRefresh: reloadData,
    );
    return listView;
  }

  _delete(List<Message> list) {
    if (list.length == 0) {
      return;
    }
    cryConfirm(context, S.of(context).confirmDelete, (context) async {
      var res = await MessageApi.removeByIds(list.map((e) => e.id).toList());
      if (!res.success!) {
        return;
      }
      CryUtils.message(S.of(context).success);
      reloadData();
    });
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
    page.current = page.current + 1;
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
