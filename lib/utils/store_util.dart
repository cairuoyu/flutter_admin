/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description: 存储工具类

import 'package:cry/model/response_body_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_admin/api/dict_api.dart';
import 'package:flutter_admin/api/menu_api.dart';
import 'package:flutter_admin/api/setting_default_tab.dart';
import 'package:flutter_admin/api/subsystem_api.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/models/subsystem.dart';
import 'package:flutter_admin/models/tab_page.dart';
import 'package:flutter_admin/models/user_info.dart';
import 'package:get_storage/get_storage.dart';

class StoreUtil {
  static read(String key) {
    return GetStorage().read(key);
  }

  static write(String key, value) {
    GetStorage().write(key, value);
  }

  static hasData(String key) {
    return GetStorage().hasData(key);
  }

  static cleanAll() {
    GetStorage().erase();
  }

  static init() {
    var list = getDefaultTabs();
    writeOpenedTabPageList(list);
    if (list.length > 0) {
      writeCurrentOpenedTabPageId(list.first.id);
    }
  }

  static List<TabPage?> readOpenedTabPageList() {
    var data = read(Constant.KEY_OPENED_TAB_PAGE_LIST);
    return data == null ? [] : List.from(data).map((e) => TabPage.fromMap(e)).toList();
  }

  static writeOpenedTabPageList(List<TabPage?> list) {
    var data = list.map((e) => e!.toMap()).toList();
    write(Constant.KEY_OPENED_TAB_PAGE_LIST, data);
  }

  static String? readCurrentOpenedTabPageId() {
    return read(Constant.KEY_CURRENT_OPENED_TAB_PAGE_ID);
  }

  static writeCurrentOpenedTabPageId(String? data) {
    write(Constant.KEY_CURRENT_OPENED_TAB_PAGE_ID, data);
  }

  static UserInfo getCurrentUserInfo() {
    var data = GetStorage().read(Constant.KEY_CURRENT_USER_INFO);
    return data == null ? UserInfo() : UserInfo.fromMap(data);
  }

  static List<Menu> getMenuList() {
    var data = GetStorage().read(Constant.KEY_MENU_LIST);
    return data == null ? [] : List.from(data).map((e) => Menu.fromMap(e)).toList();
  }

  static List<Subsystem> getSubsystemList() {
    var data = GetStorage().read(Constant.KEY_SUBSYSTEM_LIST);
    return data == null ? [] : List.from(data).map((e) => Subsystem.fromMap(e)).toList();
  }

  static Subsystem? getCurrentSubsystem() {
    var data = GetStorage().read(Constant.KEY_CURRENT_SUBSYSTEM);
    return data == null ? null : Subsystem.fromMap(data);
  }

  static List<TabPage> getDefaultTabs() {
    var data = GetStorage().read(Constant.KEY_DEFAULT_TABS);
    return data == null ? [] : List.from(data).map((e) => TabPage.fromMap(e)).toList();
  }

  static Future<bool?> loadDict() async {
    ResponseBodyApi responseBodyApi = await DictApi.map();
    if (responseBodyApi.success!) {
      StoreUtil.write(Constant.KEY_DICT_ITEM_LIST, responseBodyApi.data);
    }
    return responseBodyApi.success;
  }

  static Future<bool?> loadSubsystem() async {
    ResponseBodyApi responseBodyApi = await SubsystemApi.listEnable();
    if (responseBodyApi.success!) {
      StoreUtil.write(Constant.KEY_SUBSYSTEM_LIST, responseBodyApi.data);
      List<Subsystem> list = responseBodyApi.data == null ? [] : List.from(responseBodyApi.data).map((e) => Subsystem.fromMap(e)).toList();
      if (list.isNotEmpty) {
        StoreUtil.write(Constant.KEY_CURRENT_SUBSYSTEM, list[0].toMap());
      }
    }
    return responseBodyApi.success;
  }

  static Future<bool?> loadMenuData() async {
    var currentSubsystem = StoreUtil.getCurrentSubsystem();
    if (currentSubsystem == null) {
      return true;
    }
    ResponseBodyApi responseBodyApi = await MenuApi.listAuth(currentSubsystem.id);
    if (responseBodyApi.success!) {
      StoreUtil.write(Constant.KEY_MENU_LIST, responseBodyApi.data);
    }
    return responseBodyApi.success;
  }

  static Future<bool?> loadDefaultTabs() async {
    ResponseBodyApi responseBodyApi = await SettingDefaultTabApi.list();
    if (responseBodyApi.success!) {
      StoreUtil.write(Constant.KEY_DEFAULT_TABS, responseBodyApi.data);
    }
    return responseBodyApi.success;
  }

  static Future<void> loadPrivacy() async {
    var privacy = await rootBundle.loadString('assets/PRIVACY');
    StoreUtil.write(Constant.KEY_PRIVACY, privacy);
  }

  static String getPrivacy() {
    return StoreUtil.read(Constant.KEY_PRIVACY);
  }
}
