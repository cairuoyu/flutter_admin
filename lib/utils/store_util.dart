import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/api/dict_api.dart';
import 'package:flutter_admin/api/menu_api.dart';
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

  final Menu menuMain = Menu(id: 'dashboard', url: '/', name: 'Dashboard', nameEn: 'Dashboard');
  final Menu menu401 = Menu(id: 'layout401', url: '/layout401', name: '401', nameEn: '401');
  final Menu menuUserInfoMine = Menu(id: 'userInfoMine', url: '/userInfoMine', name: '我的信息', nameEn: 'My Info');

  List<Menu> menuOpened = [];
  String currentOpenedMenuId;

  init() async {
    await _initDict() && await _loadMenuData();
  }

  Future<bool> _loadMenuData() async {
    ResponseBodyApi responseBodyApi = await MenuApi.listAuth();
    if (responseBodyApi.success) {
      GetStorage().write(Constant.KEY_MENU_LIST, responseBodyApi.data);
    }
    return responseBodyApi.success;
  }

  Future<bool> _initDict() async {
    ResponseBodyApi responseBodyApi = await DictApi.map();
    if (responseBodyApi.success) {
      GetStorage().write(Constant.KEY_DICT_ITEM_LIST, responseBodyApi.data);
    }
    return responseBodyApi.success;
  }

  List<Menu> getMenuTree() {
    var data = GetStorage().read(Constant.KEY_MENU_LIST);
    return List.from(data).map((e) => Menu.fromMap(e)).toList();
  }

  clean() {
    GetStorage().remove(Constant.KEY_MENU_LIST);
    GetStorage().remove(Constant.KEY_DICT_ITEM_LIST);
    menuOpened = [];
    currentOpenedMenuId = null;
  }
}
