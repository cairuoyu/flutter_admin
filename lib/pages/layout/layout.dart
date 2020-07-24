import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/data/router.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/pages/common/langSwitch.dart';
import 'package:flutter_admin/pages/layout/layoutMenu.dart';
import 'package:flutter_admin/pages/login.dart';
import 'package:flutter_admin/utils/LocalStorageUtil.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:flutter_admin/vo/treeVO.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import '../../generated/l10n.dart';
import '../../vo/treeVO.dart';

class Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  List<TreeVO<Menu>> treeVOOpened = [];
  TabController tabController;
  Container content = Container();
  int length = 0;
  Color themeColor = Colors.blue;

  void changeColor(Color color) => setState(() => themeColor = color);

  @override
  void initState() {
    super.initState();

    tabController = TabController(vsync: this, length: length);
  }

  @override
  Widget build(BuildContext context) {
    TabBar tabBar = TabBar(
      onTap: (index) => _openPage(treeVOOpened[index]),
      controller: tabController,
      isScrollable: true,
      indicator: const UnderlineTabIndicator(),
      tabs: treeVOOpened.map<Tab>((TreeVO<Menu> treeVO) {
        return Tab(
          child: Row(
            children: <Widget>[
              Text(Intl.defaultLocale == 'en' ? treeVO.data.nameEn ?? '' : treeVO.data.name ?? ''),
              SizedBox(width: 3),
              InkWell(
                child: Icon(Icons.close, size: 10),
                onTap: () => _closePage(treeVO),
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
      endDrawer: _getDrawer(),
      body: body,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("FLUTTER_ADMIN"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.code),
            onPressed: () {
              Utils.launchURL("https://github.com/cairuoyu/flutter_admin");
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _logout();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings),
        onPressed: () {
          scaffoldStateKey.currentState.openEndDrawer();
        },
      ),
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

  _getDrawer() {
    var picker = BlockPicker(
      pickerColor: themeColor,
      onColorChanged: changeColor,
    );
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(S.of(context).mySettings),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            padding: EdgeInsets.all(10),
            child: LangSwitch(),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            padding: EdgeInsets.all(5),
            child: picker,
          ),
        ],
      ),
    );
  }

  _closePage(treeVO) {
    treeVOOpened.remove(treeVO);
    --length;
    tabController = TabController(vsync: this, length: length);
    var openPage;
    if (length > 0) {
      tabController.index = length - 1;
      openPage = treeVOOpened[0];
    }
    openPage(openPage);
    setState(() {});
  }

  _openPage(TreeVO<Menu> treeVO) {
    if (treeVO == null) {
      content = Container();
      return;
    }
    Widget body = treeVO.data.url != null && layoutBodys[treeVO.data.url] != null
        ? layoutBodys[treeVO.data.url]
        : Center(child: Text('404'));
    content = Container(
      child: Expanded(
        child: body,
      ),
    );

    int index = treeVOOpened.indexWhere((note) => note.data.id == treeVO.data.id);
    if (index > -1) {
      tabController.index = index;
    } else {
      treeVOOpened.add(treeVO);
      tabController = TabController(vsync: this, length: ++length);
      tabController.index = length - 1;
    }
    setState(() {});
  }

  _logout() {
    LocalStorageUtil.set(Constant.KEY_TOKEN, null);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => Login()),
    );
  }
}
