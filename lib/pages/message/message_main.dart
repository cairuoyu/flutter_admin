/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:flutter/material.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/pages/common/keep_alive_wrapper.dart';
import 'package:flutter_admin/pages/message/message_edit.dart';
import 'package:flutter_admin/pages/message/message_list.dart';
import 'package:get/get.dart';

class MessageMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var tabs = [
      Tab(child: Text(S.of(context).leaveMessage)),
      Tab(child: Text(S.of(context).allMessage)),
    ];
    var tabViews = [
      KeepAliveWrapper(child: MessageEdit()),
      KeepAliveWrapper(child: MessageList()),
    ];
    var result = DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              child: TabBar(
                tabs: tabs,
                indicator: const UnderlineTabIndicator(),
              ),
              decoration: BoxDecoration(
                color: context.theme.primaryColor,
              ),
            ),
            Expanded(child: TabBarView(children: tabViews)),
          ],
        ),
      ),
    );
    return result;
  }
}
