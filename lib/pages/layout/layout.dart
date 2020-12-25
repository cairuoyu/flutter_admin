import 'package:flutter/material.dart';
import 'package:flutter_admin/common/cry_root.dart';
import 'package:flutter_admin/enum/MenuDisplayType.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/pages/common/page_401.dart';
import 'package:flutter_admin/pages/layout/layout_app_bar.dart';
import 'package:flutter_admin/pages/layout/layout_menu.dart';
import 'package:flutter_admin/pages/layout/layout_setting.dart';
import 'package:flutter_admin/utils/store_util.dart';
import 'package:flutter_admin/utils/utils.dart';

class Layout extends StatefulWidget {
  final String path;
  final Widget content;

  Layout({this.content, this.path});

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  TabController tabController;
  Widget content;

  @override
  void initState() {
    super.initState();
    init();
    content = widget.content;
  }

  init() async {
    if (!StoreUtil.instance.inited) {
      await StoreUtil.instance.init();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!StoreUtil.instance.inited) {
      return Container();
    }
    this.handleRoute();
    var configuration = CryRootScope.of(context).state.configuration;
    Color themeColor = configuration.themeColor;
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
                onTap: () {
                  _closePage(menu);
                },
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
        configuration.menuDisplayType == MenuDisplayType.side ? layoutMenu : Container(),
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
                  child: content ?? Container(),
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
      drawer: layoutMenu,
      appBar: LayoutAppBar(
        context,
        type: 1,
        openMenu: () {
          scaffoldStateKey.currentState.openDrawer();
        },
        openSetting: () {
          scaffoldStateKey.currentState.openEndDrawer();
        },
        dispose: () {
          this.dispose();
        },
      ),
      body: body,
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.settings),
      //   onPressed: () {
      //     scaffoldStateKey.currentState.openEndDrawer();
      //   },
      // ),
    );
    return Theme(
      data: Utils.getThemeData(context),
      child: subWidget,
    );
  }

  handleRoute() {
    String path = widget.path;
    int index = StoreUtil.instance.menuOpened.indexWhere((v) => v.url == path);
    Menu menu;
    if (index < 0) {
      menu = StoreUtil.instance.menuList.firstWhere((v) {
        return v.url == path;
      }, orElse: () {
        return null;
      });
      if (menu == null) {
        StoreUtil.instance.menuOpened = [StoreUtil.instance.menu401];
        this.content = Page401();
      } else {
        StoreUtil.instance.menuOpened.add(menu);
      }
    } else {
      menu = StoreUtil.instance.menuOpened[index];
    }
    StoreUtil.instance.currentOpenedMenuId = menu?.id;
    int length = StoreUtil.instance.menuOpened.length;
    tabController = TabController(vsync: this, length: length);
    tabController.index = index > -1 ? index : (length > 0 ? length - 1 : 0);
  }

  _openPage(Menu menu) {
    Navigator.popAndPushNamed(context, menu.url);
  }

  _closePage(Menu menu) {
    int index = StoreUtil.instance.menuOpened.indexWhere((note) => note.id == menu.id);
    StoreUtil.instance.menuOpened.remove(menu);
    if (StoreUtil.instance.menuOpened.length == 0) {
      Navigator.popAndPushNamed(context, '/');
      return;
    }
    if (index == tabController.index) {
      Menu openPage = StoreUtil.instance.menuOpened[0];
      _openPage(openPage);
      return;
    }
    tabController = TabController(vsync: this, length: StoreUtil.instance.menuOpened.length);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }
}
