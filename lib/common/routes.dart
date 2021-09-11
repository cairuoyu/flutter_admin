/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:flutter/material.dart';
import 'package:flutter_admin/models/tab_page.dart';
import 'package:flutter_admin/pages/article/article_main.dart';
import 'package:flutter_admin/pages/charts/s_area_age_gender/s_area_age_gender_main.dart';
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
import 'package:flutter_admin/pages/role/role_list.dart';
import 'package:flutter_admin/pages/setting/setting_base.dart';
import 'package:flutter_admin/pages/subsystem/subsystem_main.dart';
import 'package:flutter_admin/pages/userInfo/user_info_list.dart';
import 'package:flutter_admin/pages/userInfo/user_info_mine.dart';
import 'package:flutter_admin/pages/video/video_upload.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get/get.dart';

class Routes {
  static List<GetPage>? pages;

  static Map<String, Widget> layoutPagesMap = {
    '/dashboard': Dashboard(),
    '/sAreaAgeGenderMain': SAreaAgeGenderMain(),
    '/roleList': RoleList(),
    '/personList': PersonList(),
    '/menuList': MenuMain(),
    '/userInfoList': UserInfoList(),
    '/deptMain': DeptMain(),
    '/imageUpload': ImageUpload(),
    '/videoUpload': VideoUpload(),
    '/articleMain': ArticleMain(),
    '/userInfoMine': UserInfoMine(),
    '/layout401': Page401(),
    '/layout404': Page404(),
    '/layoutTest': MyTest(1),
    '/dictList': DictList(),
    '/message': MessageMain(),
    '/subsystemList': SubsystemMain(),
    '/settingBase': SettingBase(),
    '/secondLevel': OnlyText('二级菜单页面'),
    '/threeLevel': OnlyText('三级菜单页面'),
  };
  static List<String> whiteRoutes = ['/register'];

  static List<TabPage> otherTabPage = [
    TabPage(id: 'userInfoMine', url: '/userInfoMine', name: '我的信息', nameEn: 'My Info'),
    TabPage(id: 'message', url: '/message', name: '反馈', nameEn: 'Feedback'),
  ];

  static init() {
    List<GetPage> layoutPages = layoutPagesMap.entries.map((e) => GetPage(name: e.key, page: () => e.value)).toList();
    pages = [
      GetPage(
        name: '/login',
        page: () => Login(),
      ),
      GetPage(
        name: '/',
        page: () => Layout(),
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: '/layout',
        page: () => Layout(),
        middlewares: [AuthMiddleware()],
        children: layoutPages,
      ),
    ];
  }
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return Utils.isLogin() ? null : RouteSettings(name: '/login');
  }
}
