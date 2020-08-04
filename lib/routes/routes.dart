import 'package:flutter/material.dart';
import 'package:flutter_admin/pages/common/page404.dart';
import 'package:flutter_admin/pages/dash/dashboard.dart';
import 'package:flutter_admin/pages/layout/layout.dart';
import 'package:flutter_admin/pages/layout/layoutNoRoutes.dart' as layoutNoRoutes;
import 'package:flutter_admin/pages/login.dart';
import 'package:flutter_admin/pages/menu/menuDemoList.dart';
import 'package:flutter_admin/pages/myTest.dart';
import 'package:flutter_admin/pages/person/personList.dart';

import '../pages/image/imageUpload.dart';
import '../pages/menu/menuDemoList.dart';
import '../pages/userInfo/userInfoEdit.dart';
import '../pages/video/videoUpload.dart';

Map<String, Widget> layoutRoutesData = {
  "/personList": PersonList(),
  "/dashboard": Dashboard(),
  "/menuDemoList": MenuDemoList(),
  "/userInfoEdit": UserInfoEdit(),
  "/imageUpload": ImageUpload(),
  "/videoUpload": VideoUpload(),
  "/layout404": Page404(),
};

Map<String, Widget> routesData = {
  "/layoutNoRoutes": layoutNoRoutes.Layout(),
  "/myTest": MyTest(),
  "/404": Page404(),
  "/login": Login(),
};

Map<String, WidgetBuilder> routes = routesData.map((key, value) {
  return MapEntry(key, (context) => value);
})
  ..addAll(layoutRoutesData.map((key, value) => MapEntry(
        key,
        (context) => Layout(content: value),
      )));

class Routes {
  static onGenerateRoute(RouteSettings settings) {
    //todo.. isLogin
    String name = settings.name;
    if (!routes.containsKey(name)) {
      name = "/404";
    }
    return MaterialPageRoute(builder: routes[name], settings: settings);
  }
}
