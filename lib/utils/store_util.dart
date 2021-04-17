import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/models/tab_page.dart';
import 'package:get_storage/get_storage.dart';

class StoreUtil {
  static read(String key) {
    return GetStorage().read(key);
  }

  static write(String key, value) {
    GetStorage().write(key, value);
  }

  static List<TabPage> readOpenedTabPageList() {
    var data = read(Constant.KEY_OPENED_TAB_PAGE_LIST);
    return data == null ? [] : List.from(data).map((e) => TabPage.fromMap(e)).toList();
  }

  static writeOpenedTabPageList(List<TabPage> list) {
    var data = list.map((e) => e.toMap()).toList();
    write(Constant.KEY_OPENED_TAB_PAGE_LIST, data);
  }

  static String readCurrentOpenedTabPageId() {
    return read(Constant.KEY_CURRENT_OPENED_TAB_PAGE_ID);
  }

  static writeCurrentOpenedTabPageId(data) {
    write(Constant.KEY_CURRENT_OPENED_TAB_PAGE_ID, data);
  }
}
