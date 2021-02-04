import 'package:flutter/material.dart';
import 'package:flutter_admin/models/tab_page.dart';
import 'package:flutter_admin/pages/layout/layout_app_bar.dart';
import 'package:flutter_admin/pages/layout/layout_center.dart';
import 'package:flutter_admin/pages/layout/layout_menu.dart';
import 'package:flutter_admin/pages/layout/layout_setting.dart';
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
  final TabPage menuMain = TabPage(id: 'dashboard', url: '/', name: 'Dashboard', nameEn: 'Dashboard');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GetBuilder<LayoutController>(builder: (_) => getBuild(context));

  Widget getBuild(BuildContext context) {
    var layoutMenu = LayoutMenu(onClick: (TabPage v) => Utils.openTab(v));
    Row body = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Utils.isMenuDisplayTypeDrawer(context) ? Container() : layoutMenu,
        LayoutCenter(
          key: layoutCenterKey,
          initPage: menuMain,
        ),
      ],
    );
    Scaffold subWidget = Scaffold(
      key: scaffoldStateKey,
      drawer: layoutMenu,
      endDrawer: LayoutSetting(),
      body: body,
      appBar: LayoutAppBar(
        context,
        type: 2,
        openMenu: () {
          scaffoldStateKey.currentState.openDrawer();
        },
        openSetting: () {
          scaffoldStateKey.currentState.openEndDrawer();
        },
        dispose: () {
          this.dispose();
        },
        openUserInfoMine: (TabPage tabPage) {
          Utils.openTab(tabPage);
        },
      ),
    );
    return subWidget;
  }
}
