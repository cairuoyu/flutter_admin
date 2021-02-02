import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:get_storage/get_storage.dart';

class StoreUtil {
  StoreUtil._();

  static StoreUtil _instance;

  static StoreUtil get instance => _getInstance();

  static StoreUtil _getInstance() {
    if (_instance == null) {
      _instance = StoreUtil._();
    }
    return _instance;
  }


  List<Menu> menuOpened = [];

  List<Menu> getMenuTree() {
    var data = GetStorage().read(Constant.KEY_MENU_LIST);
    return List.from(data).map((e) => Menu.fromMap(e)).toList();
  }

  clean() {
    GetStorage().remove(Constant.KEY_MENU_LIST);
    GetStorage().remove(Constant.KEY_DICT_ITEM_LIST);
    menuOpened = [];
    // currentOpenedMenuId = null;
  }
}
