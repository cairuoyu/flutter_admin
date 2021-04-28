import 'package:flutter/material.dart';
import 'package:flutter_admin/utils/cry_utils.dart';

import 'cry_route.dart';

class CryRouterDelegate extends RouterDelegate<RouteInformation> with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteInformation> {
  List<Page> pages = [];

  Map pageMap;

  CryRouterDelegate({this.pageMap}) {
    CryRoute.instance.init(this);
  }

  @override
  Widget build(BuildContext context) {
    if (pages.length == 0) {
      return Container();
    }
    return Navigator(
      key: CryUtils.navigatorKey = navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        pop();

        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(RouteInformation routeInformation) async {
    pushNamed(routeInformation.location);
  }

  pushNamedAndRemove(String name) {
    if (pages.length > 0) {
      pages.clear();
    }
    pushNamed(name);
  }

  popAndPushNamed(String name) {
    if (pages.length > 0) {
      pages.removeLast();
    }
    pushNamed(name);
  }

  pushNamed(String name) {}

  push(Widget widget) {}

  pop() {
    pages.removeLast();
    notifyListeners();
  }
}
