import 'package:flutter_admin/api/menuApi.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:flutter_admin/utils/treeUtil.dart';
import 'package:flutter_admin/vo/treeVO.dart';

class StoreUtil {
  static List<TreeVO<Menu>> treeVOList;
  static List<TreeVO<Menu>> treeVOOpened = [];

  static loadMenuData() async {
    ResponeBodyApi responeBodyApi = await MenuApi.list(null);
    var data = responeBodyApi.data;
    List<Menu> list = List.from(data).map((e) => Menu.fromJson(e)).toList();
    treeVOList = TreeUtil.toTreeVOList(list);
  }
}
