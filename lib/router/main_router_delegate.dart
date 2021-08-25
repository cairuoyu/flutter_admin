/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description: 路由代码，可根据业务自定义

import 'package:collection/collection.dart' show IterableExtension;
import 'package:cry/routes/cry_router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/common/routes.dart';
import 'package:flutter_admin/models/tab_page.dart';
import 'package:flutter_admin/pages/common/page_404.dart';
import 'package:flutter_admin/pages/layout/layout.dart';
import 'package:flutter_admin/pages/login.dart';
import 'package:flutter_admin/utils/store_util.dart';
import 'package:flutter_admin/utils/utils.dart';

class MainRouterDelegate extends CryRouterDelegate {
  MainRouterDelegate({required Map pageMap}) : super(pageMap: pageMap);

  @override
  RouteInformation get currentConfiguration {
    return RouteInformation(location: location ?? '/');
  }

  pushNamed(String name) {
    pages.add(
      MaterialPage(
        key: UniqueKey(),
        child: getPageChild(name)!,
      ),
    );

    notifyListeners();
  }

  Widget? getPageChild(String name) {
    if (!Utils.isLogin() && !Routes.whiteRoutes.contains(name)) {
      location = '/login';
      return Login();
    }
    if (name == '/' || (name == '/login' && Utils.isLogin())) {
      location = '/';
      return Layout();
    }
    if (pageMap.containsKey(name)) {
      location = name;
      return pageMap[name];
    }

    TabPage? tabPage = (StoreUtil.getDefaultTabs() + Routes.otherTabPage).firstWhereOrNull((element) => element.url == name);
    if (tabPage == null) {
      var menuList = StoreUtil.getMenuList();
      var menu = menuList.firstWhereOrNull((element) => element.url == name);
      if (menu == null) {
        location = '/404';
        return Page404();
      }
      tabPage = menu.toTabPage();
    }

    List<TabPage?> openedTabPageList = StoreUtil.readOpenedTabPageList();
    StoreUtil.writeCurrentOpenedTabPageId(tabPage!.id);
    int index = openedTabPageList.indexWhere((note) => note!.id == tabPage!.id);
    if (index <= -1) {
      openedTabPageList.add(tabPage);
      StoreUtil.writeOpenedTabPageList(openedTabPageList);
    }
    location = name;
    return Layout();
  }
}
