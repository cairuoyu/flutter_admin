import 'package:flutter_admin/api/dictItemApi.dart';
import 'package:flutter_admin/api/menuApi.dart';
import 'package:flutter_admin/models/dictItem.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/models/responeBodyApi.dart';
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
    ResponeBodyApi responeBodyApi = await MenuApi.list(null);
    List data = responeBodyApi.data;
    menuTree = List.from(data).map((e) => Menu.fromMap(e)).toList();
    menuList = menuTree + [menuMain, menuOthers];
  }

  _initDict() async {
    ResponeBodyApi all = await DictItemApi.all();
    List<DictItem> dictItemList = List.from(all.data).map((e) => DictItem.fromMap(e)).toList();
    this.dictItemMap = Map();
    this.dictSelectMap = Map();
    dictItemList.forEach((v) {
      List<DictItem> dictItemList = this.dictItemMap[v.dictId] ?? [];
      dictItemList.add(v);
      this.dictItemMap[v.dictId] = dictItemList;

      List<SelectOptionVO> selectOptionVOList = this.dictSelectMap[v.dictId] ?? [];
      selectOptionVOList.add(SelectOptionVO(value: v.code,label:v.name));
      this.dictSelectMap[v.dictId] = selectOptionVOList;
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
