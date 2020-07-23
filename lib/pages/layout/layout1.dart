import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_admin/api/menuApi.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/data/router.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:flutter_admin/pages/common/langSwitch.dart';
import 'package:flutter_admin/pages/login.dart';
import 'package:flutter_admin/utils/LocalStorageUtil.dart';
import 'package:flutter_admin/utils/treeUtil.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:flutter_admin/utils/adaptiveUtil.dart';
import 'package:flutter_admin/vo/treeVO.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import '../../generated/l10n.dart';

class Layout1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Layout1State();
}

class Layout1State extends State with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  List<TreeVO<Menu>> treeVOAll = [];
  List<TreeVO<Menu>> treeVOOpened = [];
  TabController tabController;
  Container content = Container();
  int length = 0;
  bool expandMenu = true;
  List<bool> isSelected = [true, false, false];
  Color themeColor = Colors.blue;

  void changeColor(Color color) => setState(() => themeColor = color);

  @override
  void initState() {
    super.initState();

    this.loadData();
    tabController = TabController(vsync: this, length: length);
    if (treeVOOpened.length > 0) {
      loadPage(treeVOOpened[0]);
    }
    this.expandMenu = isDisplayDesktopInit();
  }

  @override
  Widget build(BuildContext context) {
    ListTile menuHeader = ListTile(
      title: Icon(Icons.menu),
      onTap: () {
        expandMenu = !expandMenu;
        setState(() {});
      },
    );
    List<Widget> menuBody = genListTile(treeVOAll);
    ListView menu = ListView(children: [menuHeader, ...menuBody]);
    TabBar tabBar = TabBar(
      onTap: (index) => loadPage(treeVOOpened[index]),
      controller: tabController,
      isScrollable: true,
      indicator: getIndicator(),
      tabs: treeVOOpened.map<Tab>((TreeVO<Menu> treeVO) {
        return Tab(
          child: Row(
            children: <Widget>[
              Text(treeVO.data.name),
              SizedBox(width: 3),
              InkWell(
                child: Icon(Icons.close, size: 10),
                onTap: () => closePage(treeVO),
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

  loadData() async {
    ResponeBodyApi responeBodyApi = await MenuApi.list(null);
    var data = responeBodyApi.data;
    List<Menu> list = List.from(data).map((e) => Menu.fromJson(e)).toList();
    this.treeVOAll = new TreeUtil<Menu>().toTreeVOList(list);
    this.setState(() {
      if (treeVOAll.length > 0) {
        loadPage(treeVOAll[0]);
      }
    });
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

  closePage(treeVO) {
    treeVOOpened.remove(treeVO);
    --length;
    tabController = TabController(vsync: this, length: length);
    var openPage;
    if (length > 0) {
      tabController.index = length - 1;
      openPage = treeVOOpened[0];
    }
    loadPage(openPage);
    setState(() {});
  }

  loadPage(TreeVO<Menu> treeVO) {
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

  List<Widget> genListTile(List<TreeVO<Menu>> data) {
    List<Widget> listTileList = data.map<Widget>((TreeVO<Menu> treeVO) {
      IconData iconData = Utils.toIconData(treeVO.data.icon);
      String name = Intl.defaultLocale == 'en' ? treeVO.data.nameEn ?? '' : treeVO.data.name ?? '';
      Text title = Text(expandMenu ? name : '');
      if (treeVO.children != null && treeVO.children.length > 0) {
        return ExpansionTile(
          leading: Icon(expandMenu ? treeVO.icon : null),
          backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
          children: genListTile(treeVO.children),
          title: title,
        );
      } else {
        return ListTile(
          leading: Icon(iconData),
          // leading: Icon(treeVO.icon),
          title: title,
          onTap: () => loadPage(treeVO),
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
