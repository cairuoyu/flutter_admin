/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:flutter/material.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/pages/layout/layout_app_bar.dart';
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
    var layoutMenu = LayoutMenu(onClick: (Menu menu) => Utils.openTab(menu.url!));
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
            appBar: LayoutAppBar(
              context,
              type: 2,
              userInfo: StoreUtil.getCurrentUserInfo(),
              openMenu: () {
                scaffoldStateKey.currentState!.openDrawer();
              },
              openSetting: () {
                scaffoldStateKey.currentState!.openEndDrawer();
              },
            ),
          );
    return subWidget;
  }
}
