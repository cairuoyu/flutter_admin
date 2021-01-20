import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_admin/common/routes.dart';
import 'package:flutter_admin/pages/common/page_404.dart';
import 'package:flutter_admin/pages/layout/layout_app_bar.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/pages/layout/layout_menu.dart';
import 'package:flutter_admin/pages/layout/layout_setting.dart';
import 'package:flutter_admin/utils/store_util.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get/get.dart';

class Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  TabController tabController;
  Container content = Container();
  int length = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    if (!StoreUtil.instance.inited) {
      await StoreUtil.instance.init();
      _openPage(StoreUtil.instance.menuMain);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!StoreUtil.instance.inited) {
      return Container();
    }

    handleRoute();

    TabBar tabBar = TabBar(
      onTap: (index) => _openPage(StoreUtil.instance.menuOpened[index]),
      controller: tabController,
      isScrollable: true,
      indicator: const UnderlineTabIndicator(),
      tabs: StoreUtil.instance.menuOpened.map<Tab>((Menu menu) {
        return Tab(
          child: Row(
            children: <Widget>[
              Text(Utils.isLocalEn(context) ? menu.nameEn ?? '' : menu.name ?? ''),
              SizedBox(width: 3),
              InkWell(
                child: Icon(Icons.close, size: 10),
                onTap: () => _closePage(menu),
              ),
            ],
          ),
        );
      }).toList(),
    );

    var layoutMenu = LayoutMenu(onClick: _openPage);
    Row body = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        layoutMenu,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: tabBar,
                      decoration: BoxDecoration(
                        color: Get.find().themeColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(2.0, 2.0),
                            blurRadius: 4.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              content,
            ],
          ),
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
        openUserInfoMine: (menu) {
          _openPage(menu);
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.settings),
      //   onPressed: () {
      //     scaffoldStateKey.currentState.openEndDrawer();
      //   },
      // ),
    );
    return subWidget;
  }

  handleRoute() {
    int index = StoreUtil.instance.menuOpened.indexWhere((note) => note.id == StoreUtil.instance.currentOpenedMenuId);
    Menu menu = index == -1 ? null : StoreUtil.instance.menuOpened[index];
    if (menu == null) {
      content = Container();
      tabController = TabController(vsync: this, length: 0);
      return;
    }
    Widget body = menu.url != null && layoutRoutesData[menu.url] != null ? layoutRoutesData[menu.url] : Page404();
    content = Container(
      child: Expanded(
        child: body,
      ),
    );

    length = StoreUtil.instance.menuOpened.length;
    tabController = TabController(vsync: this, length: length);
    tabController.index = index;
  }

  _closePage(menu) {
    StoreUtil.instance.menuOpened.remove(menu);
    var length = StoreUtil.instance.menuOpened.length;
    StoreUtil.instance.currentOpenedMenuId = length > 0 ? StoreUtil.instance.menuOpened[length - 1].id : null;
    setState(() {});
  }

  _openPage(Menu menu) {
    if (!StoreUtil.instance.menuOpened.contains(menu)) {
      StoreUtil.instance.menuOpened.add(menu);
    }
    StoreUtil.instance.currentOpenedMenuId = menu.id;
    setState(() {});
  }
}
