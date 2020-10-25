import 'package:flutter_admin/api/dictApi.dart';
import 'package:flutter_admin/api/menuApi.dart';
import 'package:flutter_admin/models/dictItem.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/models/responseBodyApi.dart';
import 'package:flutter_admin/vo/selectOptionVO.dart';

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

  final Menu menuMain = Menu(url: '/', name: 'Dashboard', nameEn: 'Dashboard');
  final Menu menu401 = Menu(url: '/layout401', name: '401', nameEn: '401');
  final Menu menuOthers = Menu(url: '/userInfoMine', name: '我的信息', nameEn: 'My Info');
  bool inited = false;
  Map<String, List<DictItem>> dictItemMap;
  Map<String, List<SelectOptionVO>> dictSelectMap;

  List<Menu> menuList;
  List<Menu> menuTree;
  List<Menu> menuOpened = [];

  init() async {
    await _initDict();
    await _loadMenuData();
    this.inited = true;
  }

  _loadMenuData() async {
    ResponseBodyApi responseBodyApi = await MenuApi.list(null);
    List data = responseBodyApi.data;
    menuTree = List.from(data).map((e) => Menu.fromMap(e)).toList();
    menuList = menuTree + [menuMain, menuOthers];
  }

  _initDict() async {
    ResponseBodyApi map = await DictApi.map();
    this.dictSelectMap = Map();
    this.dictItemMap = Map.from(map.data).map<String, List<DictItem>>((key, value) {
      List<DictItem> list = (value as List).map((e) => DictItem.fromMap(e)).toList();
      this.dictSelectMap[key] = list.map((e) => SelectOptionVO(value: e.code, label: e.name)).toList();
      return MapEntry(key, list);
    });
  }

  clean() {
    menuList = null;
    menuTree = null;
    menuOpened = [];
    dictItemMap = null;
    inited = false;
  }
}
