import 'package:flutter/material.dart';
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
import 'package:flutter_admin/pages/subsystem/subsystem_main.dart';
import 'package:flutter_admin/pages/userInfo/user_info_list.dart';
import 'package:flutter_admin/pages/userInfo/user_info_mine.dart';
import 'package:flutter_admin/pages/video/video_upload.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get/get.dart';

class Routes {
  static List<GetPage> pages;
  static List<GetPage> layoutPages;

  static Map<String, Widget> layoutPagesMap = {
    '/': Dashboard(),
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
    '/secondLevel': OnlyText('二级菜单页面'),
    '/threeLevel': OnlyText('三级菜单页面'),
  };

  static init() {
    layoutPages = [
      GetPage(
        name: '/u',
        page: () => UserInfoList(),
      ),
      GetPage(
        name: '/userInfoList',
        page: () => UserInfoList(),
      ),
      GetPage(
        name: '/a',
        page: () => ArticleMain(),
      ),
    ];
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
  RouteSettings redirect(String route) {
    return Utils.isLogin() ? null : RouteSettings(name: '/login');
  }
}
