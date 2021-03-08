import 'package:flutter/material.dart';
import 'package:flutter_admin/pages/charts/s_area_age_gender/s_area_age_gender_main.dart';
import 'package:flutter_admin/pages/common/commonNavigator.dart';
import 'package:flutter_admin/pages/common/only_text.dart';
import 'package:flutter_admin/pages/common/page_401.dart';
import 'package:flutter_admin/pages/common/page_404.dart';
import 'package:flutter_admin/pages/dash/dashboard.dart';
import 'package:flutter_admin/pages/dept/dept_main.dart';
import 'package:flutter_admin/pages/dict/dict_list.dart';
import 'package:flutter_admin/pages/image/image_upload.dart';
import 'package:flutter_admin/pages/layout/layout.dart';
import 'package:flutter_admin/pages/login.dart';
import 'package:flutter_admin/pages/menu/menu_main.dart';
import 'package:flutter_admin/pages/message/message_main.dart';
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
  '/sAreaAgeGenderMain': SAreaAgeGenderMain(),
  '/roleList': RoleList(),
  '/personList': PersonList(),
  '/menuList': CommonNavigator(MenuMain()),
  '/userInfoList': UserInfoList(),
  '/deptMain': DeptMain(),
  '/imageUpload': ImageUpload(),
  '/videoUpload': VideoUpload(),
  '/userInfoMine': UserInfoMine(),
  '/layout401': Page401(),
  '/layout404': Page404(),
  '/layoutTest': MyTest(1),
  '/dictList': DictList(),
  '/message': MessageMain(),
  '/subsystemList': SubsystemMain(),
  '/secondLevel': OnlyText('二级菜单页面'),
  '/threeLevel': OnlyText('三级菜单页面'),
};

Map<String, Widget> routesData = {
  '/login': Login(),
  '/register': Register(),
  '/': Layout(),
  '/401': Page404(),
  '/404': Page404(),
  '/myTest': MyTest(1),
};
List<String> whiteRouters = ['/register', '/myTest'];

Map<String, WidgetBuilder> routes = routesData.map((key, value) {
  return MapEntry(key, (context) => value);
});

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
