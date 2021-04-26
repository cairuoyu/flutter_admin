import 'package:flutter/material.dart';
import 'package:flutter_admin/common/cry_router_delegate.dart';
import 'package:flutter_admin/models/tab_page.dart';
import 'package:flutter_admin/pages/common/page_404.dart';
import 'package:flutter_admin/pages/layout/layout.dart';
import 'package:flutter_admin/pages/login.dart';
import 'package:flutter_admin/utils/store_util.dart';
import 'package:flutter_admin/utils/utils.dart';

class MainRouterDelegate extends CryRouterDelegate {
  MainRouterDelegate({Map pageMap}) : super(pageMap: pageMap);
  List<String> whiteRoutes = ['/register'];
  String location;

  @override
  RouteInformation get currentConfiguration {
    return RouteInformation(location: location ?? '/');
  }

  @override
  Future<void> setNewRoutePath(RouteInformation routeInformation) async {
    popAndPushNamed(routeInformation.location);
  }

  push(Widget widget) {
    pages.add(
      MaterialPage(
        key: UniqueKey(),
        child: widget,
      ),
    );

    notifyListeners();
  }

  pushNamed(String name) {
    pages.add(
      MaterialPage(
        key: UniqueKey(),
        child: getPageChild(name),
      ),
    );

    notifyListeners();
  }

  Widget getPageChild(String name) {
    if (!Utils.isLogin() && !whiteRoutes.contains(name)) {
      location = '/login';
      return Login();
    }
    if (pageMap.containsKey(name)) {
      location = name;
      return pageMap[name];
    }
    var menuList = StoreUtil.getMenuTree();
    var menu = menuList.firstWhere((element) => element.url == name, orElse: () => null);
    if (menu == null) {
      location = '/404';
      return Page404();
    }

    TabPage tabPage = menu.toTabPage();
    List<TabPage> openedTabPageList = StoreUtil.readOpenedTabPageList();
    StoreUtil.writeCurrentOpenedTabPageId(tabPage.id);
    int index = openedTabPageList.indexWhere((note) => note.id == tabPage.id);
    if (index <= -1) {
      openedTabPageList.add(tabPage);
      StoreUtil.writeOpenedTabPageList(openedTabPageList);
    }
    location = name;
    return Layout();
  }
}
