import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_admin/components/cryRoot.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/pages/layout/layoutAppBar.dart';
import 'package:flutter_admin/pages/layout/layoutMenu.dart';
import 'package:flutter_admin/pages/layout/layoutSetting.dart';
import 'package:flutter_admin/utils/storeUtil.dart';
import 'package:flutter_admin/vo/treeVO.dart';
import 'package:intl/intl.dart';

class Layout extends StatefulWidget {
  final Widget content;
  Layout({this.content});
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: StoreUtil.treeVOOpened.length);
  }

  @override
  Widget build(BuildContext context) {
    String url = ModalRoute.of(context).settings.name;
    int index = StoreUtil.treeVOOpened.indexWhere((v) => v.data.url == url);

    if (index > -1) {
      tabController.index = index;
    } else {
      if (StoreUtil.treeVOList == null) {
        StoreUtil.loadMenuData().then((res) {
          setState(() {});
        });
        return Container();
      }

      TreeVO<Menu> treeVO = StoreUtil.treeVOList.firstWhere((v) {
        return v.data.url == url;
      }, orElse: () => null);
      if (treeVO != null) {
        StoreUtil.treeVOOpened.add(treeVO);
        tabController = TabController(vsync: this, length: StoreUtil.treeVOOpened.length);
        tabController.index = StoreUtil.treeVOOpened.length - 1;
      }
    }
    Color themeColor = CryRootScope.of(context).state.themeColor;
    TabBar tabBar = TabBar(
      onTap: (index) => _openPage(StoreUtil.treeVOOpened[index]),
      controller: tabController,
      isScrollable: true,
      indicator: const UnderlineTabIndicator(),
      tabs: StoreUtil.treeVOOpened.map<Tab>((TreeVO<Menu> treeVO) {
        return Tab(
          child: Row(
            children: <Widget>[
              Text(Intl.defaultLocale == 'en' ? treeVO.data.nameEn ?? '' : treeVO.data.name ?? ''),
              SizedBox(width: 3),
              InkWell(
                child: Icon(Icons.close, size: 10),
                onTap: () {
                  if (StoreUtil.treeVOOpened.length > 1) {
                    _closePage(treeVO);
                  }
                },
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
              Container(
                child: Expanded(
                  child: widget.content ?? Container(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    Scaffold subWidget = Scaffold(
      key: scaffoldStateKey,
      endDrawer: LayoutSetting(),
      appBar: LayoutAppBar(context, type: 1, openSetting: () {
        scaffoldStateKey.currentState.openEndDrawer();
      }),
      body: body,
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

  _openPage(TreeVO<Menu> treeVO) {
    int index = StoreUtil.treeVOOpened.indexWhere((note) => note.data.id == treeVO.data.id);
    if (index == -1) {
      StoreUtil.treeVOOpened.add(treeVO);
    }
    dispose();
    Navigator.pushNamed(context, treeVO.data.url);
  }

  _closePage(TreeVO<Menu> treeVO) {
    int index = StoreUtil.treeVOOpened.indexWhere((note) => note.data.id == treeVO.data.id);
    StoreUtil.treeVOOpened.remove(treeVO);
    if (StoreUtil.treeVOOpened.length == 0) {
      dispose();
      Navigator.pushNamed(context, '/dashboard');
      return;
    }
    if (index == tabController.index) {
      TreeVO<Menu> openPage = StoreUtil.treeVOOpened[0];
      _openPage(openPage);
      return;
    }
    tabController = TabController(vsync: this, length: StoreUtil.treeVOOpened.length);
    setState(() {});
  }

  @override
  void dispose() async {
    tabController.dispose();
    super.dispose();
  }
}
