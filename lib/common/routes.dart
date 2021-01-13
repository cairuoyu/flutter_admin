import 'package:flutter/material.dart';
import 'package:flutter_admin/pages/common/commonNavigator.dart';
import 'package:flutter_admin/pages/common/only_text.dart';
import 'package:flutter_admin/pages/common/page_401.dart';
import 'package:flutter_admin/pages/common/page_404.dart';
import 'package:flutter_admin/pages/dash/dashboard.dart';
import 'package:flutter_admin/pages/dict/dict_list.dart';
import 'package:flutter_admin/pages/image/image_upload.dart';
import 'package:flutter_admin/pages/layout/layout.dart';
import 'package:flutter_admin/pages/layout/layout_no_routes.dart' as layoutNoRoutes;
import 'package:flutter_admin/pages/login.dart';
import 'package:flutter_admin/pages/menu/menu_main.dart';
import 'package:flutter_admin/pages/message/message.dart';
import 'package:flutter_admin/pages/my_test.dart';
import 'package:flutter_admin/pages/person/person_list.dart';
import 'package:flutter_admin/pages/register.dart';
import 'package:flutter_admin/pages/role/role_list.dart';
import 'package:flutter_admin/pages/subsystem/subsystem_main.dart';
import 'package:flutter_admin/pages/userInfo/user_info_list.dart';
import 'package:flutter_admin/pages/userInfo/user_info_mine.dart';
import 'package:flutter_admin/pages/video/video_upload.dart';
import 'package:flutter_admin/utils/utils.dart';

Map<String, Widget> layoutRoutesData = {
  '/': Dashboard(),
  '/roleList': RoleList(),
  '/personList': PersonList(),
  '/menuDemoList': CommonNavigator(MenuMain()),
  '/userInfoList': UserInfoList(),
  '/imageUpload': ImageUpload(),
  '/videoUpload': VideoUpload(),
  '/userInfoMine': UserInfoMine(),
  '/layout401': Page401(),
  '/layout404': Page404(),
  '/layoutTest': MyTest(),
  '/dictList': DictList(),
  '/message': Message(),
  '/subsystemList': CommonNavigator(SubsystemMain()),
  '/secondLevel': OnlyText('二级菜单页面'),
  '/threeLevel': OnlyText('三级菜单页面'),
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
