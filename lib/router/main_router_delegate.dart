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


  @override
  Future<void> setNewRoutePath(RouteInformation routeInformation) async {
    popAndPushNamed(routeInformation.location);
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
    if (!Utils.isLogin()) {
      return Login();
    }
    if (pageMap.containsKey(name)) {
      return pageMap[name];
    }
    var menuList = StoreUtil.getMenuTree();
    var menu = menuList.firstWhere((element) => element.url == name, orElse: () => null);
    if (menu == null) {
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
    return Layout();
  }
}
