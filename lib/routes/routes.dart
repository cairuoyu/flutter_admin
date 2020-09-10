import 'package:flutter/material.dart';
import 'package:flutter_admin/pages/common/page401.dart';
import 'package:flutter_admin/pages/common/page404.dart';
import 'package:flutter_admin/pages/dash/dashboard.dart';
import 'package:flutter_admin/pages/layout/layout.dart';
import 'package:flutter_admin/pages/layout/layoutNoRoutes.dart' as layoutNoRoutes;
import 'package:flutter_admin/pages/login.dart';
import 'package:flutter_admin/pages/menu/menuDemoList.dart';
import 'package:flutter_admin/pages/myTest.dart';
import 'package:flutter_admin/pages/person/personList.dart';
import 'package:flutter_admin/pages/register.dart';
import 'package:flutter_admin/pages/role/roleList.dart';
import 'package:flutter_admin/pages/userInfo/userInfoList.dart';
import 'package:flutter_admin/pages/userInfo/userInfoMine.dart';
import 'package:flutter_admin/utils/utils.dart';

import '../pages/image/imageUpload.dart';
import '../pages/menu/menuDemoList.dart';
import '../pages/video/videoUpload.dart';

Map<String, Widget> layoutRoutesData = {
  '/': Dashboard(),
  '/roleList': RoleList(),
  '/personList': PersonList(),
  '/menuDemoList': MenuDemoList(),
  '/userInfoList': UserInfoList(),
  '/imageUpload': ImageUpload(),
  '/videoUpload': VideoUpload(),
  '/userInfoMine': UserInfoMine(),
  '/layout401': Page401(),
  '/layout404': Page404(),
  '/layoutTest': MyTest(),
};

Map<String, Widget> routesData = {
  '/layoutNoRoutes': layoutNoRoutes.Layout(),
  '/register': Register(),
  '/myTest': MyTest(),
  '/401': Page404(),
  '/404': Page404(),
//  '/': Layout(path: '/',),
  '/login': Login(),
  '/test': RoleList(),
};
List<String> whiteRouters = ['/register'];

Map<String, WidgetBuilder> routes = routesData.map((key, value) {
  return MapEntry(key, (context) => value);
})
  ..addAll(layoutRoutesData.map((key, value) => MapEntry(
        key,
        (context) => Layout(content: value, path: key),
      )));

class Routes {
  static onGenerateRoute(RouteSettings settings) {
    String name = settings.name;
    if (!routes.containsKey(name)) {
      name = '/404';
    } else if (!Utils.isLogin() && !whiteRouters.contains(name)) {
      name = '/login';
    }
    return MaterialPageRoute(builder: routes[name], settings: settings);
  }
}
