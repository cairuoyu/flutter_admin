import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/data/data1.dart';
import 'package:flutter_admin/pages/common/langSwitch.dart';
import 'package:flutter_admin/pages/login.dart';
import 'package:flutter_admin/utils/LocalStorageUtil.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:flutter_admin/utils/adaptiveUtil.dart';
import 'package:flutter_admin/vo/pageVO.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import '../../generated/l10n.dart';

class Layout1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Layout1State();
}

class Layout1State extends State with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  List<PageVO> pageVoAll;
  List<PageVO> pageVoOpened;
  TabController tabController;
  Container content;
  int length;
  bool expandMenu = true;
  List<bool> isSelected = [true, false, false];
  Color themeColor = Colors.blue;

  void changeColor(Color color) => setState(() => themeColor = color);

  @override
  void initState() {
    super.initState();

    pageVoAll = Intl.defaultLocale == 'en' ? testPageVOAll_en : testPageVOAll;

    pageVoOpened = <PageVO>[pageVoAll[0]];
    length = pageVoOpened.length;
    tabController = TabController(vsync: this, length: length);
    if (pageVoOpened.length > 0) {
      loadPage(pageVoOpened[0]);
    }
    this.expandMenu = isDisplayDesktopInit();
    WidgetsBinding.instance.addPostFrameCallback((v) {
      // scaffoldStateKey.currentState.openEndDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    pageVoAll = Intl.defaultLocale == 'en' ? testPageVOAll_en : testPageVOAll;
    ListTile menuHeader = ListTile(
      title: Icon(Icons.menu),
      onTap: () {
        expandMenu = !expandMenu;
        setState(() {});
      },
    );
    List<Widget> menuBody = genListTile(pageVoAll);
    ListView menu = ListView(children: [menuHeader, ...menuBody]);
    TabBar tabBar = TabBar(
      onTap: (index) => loadPage(pageVoOpened[index]),
      controller: tabController,
      isScrollable: true,
      indicator: getIndicator(),
      tabs: pageVoOpened.map<Tab>((PageVO page) {
        return Tab(
          // text: page.title,
          child: Row(
            children: <Widget>[
              Text(page.title),
              SizedBox(width: 3),
              InkWell(
                child: Icon(Icons.close, size: 10),
                onTap: () => closePage(page),
              ),
            ],
          ),
        );
      }).toList(),
    );

    Row body = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: expandMenu ? 300 : 60,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[50],
              // border: Border(right: BorderSide(color: Colors.black)),
            ),
            child: menu,
          ),
        ),
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
      endDrawer: getDrawer(),
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
              logout();
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

  getColorPicker() {
    var picker = BlockPicker(
      pickerColor: themeColor,
      onColorChanged: changeColor,
    );
    return picker;
  }

  getDrawer() {
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
            child: getColorPicker(),
          ),
        ],
      ),
    );
  }

  closePage(page) {
    pageVoOpened.remove(page);
    --length;
    tabController = TabController(vsync: this, length: length);
    var openPage;
    if (length > 0) {
      tabController.index = length - 1;
      openPage = pageVoOpened[0];
    }
    loadPage(openPage);
    setState(() {});
  }

  loadPage(page) {
    if (page == null) {
      content = Container();
      return;
    }
    content = Container(
      child: Expanded(
        child: page.widget != null ? page.widget : Center(child: Text('404')),
      ),
    );

    int index = pageVoOpened.indexWhere((note) => note.id == page.id);
    if (index > -1) {
      tabController.index = index;
    } else {
      pageVoOpened.add(page);
      tabController = TabController(vsync: this, length: ++length);
      tabController.index = length - 1;
    }
    setState(() {});
  }

  List<Widget> genListTile(data) {
    List<Widget> listTileList = data.map<Widget>((PageVO page) {
      Text title = Text(expandMenu ? page.title : '');
      if (page.children != null && page.children.length > 0) {
        return ExpansionTile(
          leading: Icon(expandMenu ? page.icon : null),
          backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
          children: genListTile(page.children),
          title: title,
        );
      } else {
        return ListTile(
          leading: Icon(page.icon),
          title: title,
          onTap: () => loadPage(page),
        );
      }
    }).toList();
    return listTileList;
  }

  logout() {
    LocalStorageUtil.set(Constant.KEY_TOKEN, null);
    // Navigator.of(context, rootNavigator: true).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => Login()),
    );
  }

  getIndicator() {
    return const UnderlineTabIndicator();
  }
}
