import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_admin/components/cryRoot.dart';
import 'package:flutter_admin/models/configuration.dart';
import 'package:flutter_admin/pages/common/page404.dart';
import 'package:flutter_admin/pages/layout/layoutAppBar.dart';
import 'package:flutter_admin/routes/routes.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/pages/layout/layoutMenu.dart';
import 'package:flutter_admin/pages/layout/layoutSetting.dart';
import 'package:flutter_admin/utils/storeUtil.dart';

class Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  List<Menu> menuOpened = [];
  TabController tabController;
  Container content = Container();
  int length = 0;

  @override
  void initState() {
    super.initState();

    tabController = TabController(vsync: this, length: length);
  }

  @override
  Widget build(BuildContext context) {
    if (StoreUtil.menuTree == null) {
      StoreUtil.loadMenuData().then((res) {
        setState(() {});
      });
      return Container();
    }

    Color themeColor = CryRootScope.of(context).state.configuration.themeColor;
    TabBar tabBar = TabBar(
      onTap: (index) => _openPage(menuOpened[index]),
      controller: tabController,
      isScrollable: true,
      indicator: const UnderlineTabIndicator(),
      tabs: menuOpened.map<Tab>((Menu menu) {
        return Tab(
          child: Row(
            children: <Widget>[
              Text(Configuration.of(context).locale == 'en' ? menu.nameEn ?? '' : menu.name ?? ''),
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

    Row body = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        LayoutMenu(onClick: _openPage),
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
                        color: themeColor,
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
      endDrawer: LayoutSetting(),
      body: body,
      appBar: LayoutAppBar(context, type: 2, openSetting: () {
        scaffoldStateKey.currentState.openEndDrawer();
      }),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.settings),
      //   onPressed: () {
      //     scaffoldStateKey.currentState.openEndDrawer();
      //   },
      // ),
    );
    return Theme(
      data: ThemeData(
        primaryColor: themeColor,
        iconTheme: IconThemeData(color: themeColor),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: themeColor,
        ),
        buttonTheme: ButtonThemeData(buttonColor: themeColor),
      ),
      child: subWidget,
    );
  }

  _closePage(menu) {
    menuOpened.remove(menu);
    --length;
    tabController = TabController(vsync: this, length: length);
    var openPage;
    if (length > 0) {
      tabController.index = length - 1;
      openPage = menuOpened[0];
    }
    _openPage(openPage);
    setState(() {});
  }

  _openPage(Menu menu) {
    if (menu == null) {
      content = Container();
      return;
    }
    Widget body = menu.url != null && layoutRoutesData[menu.url] != null ? layoutRoutesData[menu.url] : Page404();
    content = Container(
      child: Expanded(
        child: body,
      ),
    );

    int index = menuOpened.indexWhere((note) => note.id == menu.id);
    if (index > -1) {
      tabController.index = index;
    } else {
      menuOpened.add(menu);
      tabController = TabController(vsync: this, length: ++length);
      tabController.index = length - 1;
    }
    setState(() {});
  }
}
