import 'package:flutter_admin/api/menuApi.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/models/responeBodyApi.dart';

class StoreUtil {
  static List<Menu> menuList;
  static List<Menu> menuTree;
  static List<Menu> menuOthers = [menuMain, Menu(url: '/userInfoMine', name: '我的信息', nameEn: 'My Info')];
  static List<Menu> menuOpened = [];
  static Menu menuMain = Menu(url: '/', name: 'Dashboard', nameEn: 'Dashboard');
  static Menu menu401= Menu(url: '/layout401', name: '401', nameEn: '401');

  static resetMenu() {
    menuList = null;
    menuTree = null;
    menuOpened = [];
  }

  static loadMenuData() async {
    ResponeBodyApi responeBodyApi = await MenuApi.list(null);
    List data = responeBodyApi.data;
    menuTree = List.from(data).map((e) => Menu.fromMap(e)).toList();
    menuList = menuTree + menuOthers;
  }
}
