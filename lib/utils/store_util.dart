import 'package:bot_toast/bot_toast.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:cry/vo/select_option_vo.dart';
import 'package:flutter_admin/api/dict_api.dart';
import 'package:flutter_admin/api/menu_api.dart';
import 'package:flutter_admin/models/dict_item.dart';
import 'package:flutter_admin/models/menu.dart';

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
  bool inited = false;
  Map<String, List<DictItem>> dictItemMap;
  Map<String, List<SelectOptionVO>> dictSelectMap;

  List<Menu> menuList;
  List<Menu> menuTree;
  List<Menu> menuOpened = [];
  String currentOpenedMenuId;

  init() async {
    BotToast.showLoading();
    this.inited = await _initDict() && await _loadMenuData();
    BotToast.closeAllLoading();
  }

  Future<bool> _loadMenuData() async {
    ResponseBodyApi responseBodyApi = await MenuApi.listAuth();
    if (responseBodyApi.success) {
      List data = responseBodyApi.data;
      menuTree = List.from(data).map((e) => Menu.fromMap(e)).toList();
      menuList = menuTree + [menuMain, menuUserInfoMine];
    }
    return responseBodyApi.success;
  }

  Future<bool> _initDict() async {
    ResponseBodyApi responseBodyApi = await DictApi.map();
    if (responseBodyApi.success) {
      this.dictSelectMap = Map();
      this.dictItemMap = Map.from(responseBodyApi.data).map<String, List<DictItem>>((key, value) {
        List<DictItem> list = (value as List).map((e) => DictItem.fromMap(e)).toList();
        this.dictSelectMap[key] = list.map((e) => SelectOptionVO(value: e.code, label: e.name)).toList();
        return MapEntry(key, list);
      });
    }
    return responseBodyApi.success;
  }

  clean() {
    menuList = null;
    menuTree = null;
    menuOpened = [];
    dictItemMap = null;
    inited = false;
    currentOpenedMenuId = null;
  }
}
