/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry.dart';
import 'package:cry/cry_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/pages/layout/layout_center.dart';
import 'package:flutter_admin/pages/layout/layout_menu.dart';
import 'package:flutter_admin/pages/layout/layout_setting.dart';
import 'package:flutter_admin/utils/store_util.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get/get.dart';

import 'layout_controller.dart';

class Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LayoutCenterState> layoutCenterKey = GlobalKey<LayoutCenterState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GetBuilder<LayoutController>(builder: (_) => _build(context));

  Widget _build(BuildContext context) {
    var layoutMenu = LayoutMenu(onClick: (Menu menu) => Utils.openTab(menu.id!));
    LayoutController layoutController = Get.find();
    Row body = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Utils.isMenuDisplayTypeDrawer(context) || layoutController.isMaximize ? Container() : layoutMenu,
        LayoutCenter(key: layoutCenterKey),
      ],
    );
    Scaffold subWidget = layoutController.isMaximize
        ? Scaffold(
            body: body,
          )
        : Scaffold(
            key: scaffoldStateKey,
            drawer: layoutMenu,
            endDrawer: LayoutSetting(),
            body: body,
            appBar: getAppBar(),
          );
    return subWidget;
  }

  getAppBar() {
    var userInfo = StoreUtil.getCurrentUserInfo();
    var subsystemList = StoreUtil.getSubsystemList();
    var currentSubsystem = StoreUtil.getCurrentSubsystem();
    return AppBar(
      automaticallyImplyLeading: false,
      leading: !Utils.isMenuDisplayTypeDrawer(context)
          ? Tooltip(
              message: 'Home',
              child: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Utils.launchURL('http://www.cairuoyu.com');
                },
              ))
          : Tooltip(
              message: 'Menu',
              child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  scaffoldStateKey.currentState!.openDrawer();
                },
              )),
      title: Row(children: [
        Text(currentSubsystem?.name ?? '--'),
        PopupMenuButton(
            tooltip: '选择子系统',
            onSelected: (String v) async {
              var subsystem = subsystemList.firstWhere((element) => element.id == v);
              StoreUtil.write(Constant.KEY_CURRENT_SUBSYSTEM, subsystem.toMap());
              await StoreUtil.loadMenuData();
              StoreUtil.init();
              setState(() {});
            },
            itemBuilder: (context) => subsystemList
                .map<PopupMenuEntry<String>>(
                  (e) => PopupMenuItem<String>(
                    value: e.id,
                    child: ListTile(
                      title: Text(e.name ?? '--'),
                    ),
                  ),
                )
                .toList()),
      ]),
      actions: <Widget>[
        Tooltip(
          message: 'Setting',
          child: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              scaffoldStateKey.currentState!.openEndDrawer();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PopupMenuButton(
            tooltip: S.of(context).information,
            onSelected: (dynamic v) {
              if (v == 'info') {
                Utils.openTab('userInfoMine');
              } else if (v == 'logout') {
                Utils.logout();
                Cry.pushNamedAndRemove('/login');
              }
            },
            child: Align(
              child: userInfo.avatarUrl == null
                  ? Icon(Icons.person)
                  : CircleAvatar(
                      backgroundImage: NetworkImage(userInfo.avatarUrl!),
                      radius: 12.0,
                    ),
            ),
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'info',
                child: ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(S.of(context).myInformation),
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(S.of(context).logout),
                ),
              ),
            ],
          ),
        ),
        PopupMenuButton(
          onSelected: (dynamic v) {
            switch (v) {
              case 'code':
                Utils.launchURL("https://github.com/cairuoyu/flutter_admin");
                break;
              case 'about':
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Flutter admin'),
                      scrollable: true,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Author：CaiRuoyu'),
                          SizedBox(height: 20),
                          Text('Github：https://github.com/cairuoyu/flutter_admin'),
                          SizedBox(height: 20),
                          Text('Flutter admin版本：1.4.0'),
                          SizedBox(height: 20),
                          Text('Flutter SDK版本：2.2.0'),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(S.of(context).cancel),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
                break;
              case 'feedback':
                Utils.openTab('message');
                break;
              case 'privacy':
                var privacy = StoreUtil.getPrivacy();
                cryAlert(context, privacy);
                break;
            }
          },
          itemBuilder: (context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'code',
              child: ListTile(
                leading: const Icon(Icons.code),
                title: Text('源码'),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem<String>(
              value: 'feedback',
              child: ListTile(
                leading: const Icon(Icons.feedback),
                title: Text('反馈'),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem<String>(
              value: 'about',
              child: ListTile(
                leading: const Icon(Icons.vertical_split),
                title: Text('关于'),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem<String>(
              value: 'privacy',
              child: ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: Text('隐私'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
