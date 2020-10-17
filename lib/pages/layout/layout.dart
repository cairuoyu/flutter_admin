import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/components/cryRoot.dart';
import 'package:flutter_admin/models/configuration.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/pages/common/page401.dart';
import 'package:flutter_admin/pages/layout/layoutAppBar.dart';
import 'package:flutter_admin/pages/layout/layoutMenu.dart';
import 'package:flutter_admin/pages/layout/layoutSetting.dart';
import 'package:flutter_admin/utils/storeUtil.dart';
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
      StoreUtil.instance.init().then((res) {
        setState(() {
          BotToast.closeAllLoading();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!StoreUtil.instance.inited) {
      BotToast.showLoading();
      return Container();
    }
    this.handleRoute();
    Color themeColor = CryRootScope.of(context).state.configuration.themeColor;
    TabBar tabBar = TabBar(
      onTap: (index) => _openPage(StoreUtil.instance.menuOpened[index]),
      controller: tabController,
      isScrollable: true,
      indicator: const UnderlineTabIndicator(),
      tabs: StoreUtil.instance.menuOpened.map<Tab>((Menu menu) {
        return Tab(
          child: Row(
            children: <Widget>[
              Text(Configuration.of(context).locale == 'en' ? menu.nameEn ?? '' : menu.name ?? ''),
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
      appBar: LayoutAppBar(
        context,
        type: 1,
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
    if (index < 0) {
      Menu menu = StoreUtil.instance.menuList.firstWhere((v) {
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
    }
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
