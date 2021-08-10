/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description: 数据字典工具

import 'package:cry/vo/select_option_vo.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/utils/store_util.dart';

class DictUtil {
  static List getDictItemList(String dictCode) {
    var data = StoreUtil.read(Constant.KEY_DICT_ITEM_LIST);
    if (data == null) {
      return [];
    }
    var map = Map.from(data);
    return map[dictCode] ?? [];
  }

  static List<SelectOptionVO> getDictSelectOptionList(String dictCode) {
    return getDictItemList(dictCode).map((e) => SelectOptionVO(value: e['code'], label: e['name'])).toList();
  }

  static String? getDictItemName(String? code, String dictCode, {defaultValue = ''}) {
    if (code == null) {
      return defaultValue;
    }
    Map? result = getDictItemList(dictCode).firstWhere((v) {
      return v['code'] == code;
    }, orElse: () {
      return null;
    });
    if (result == null) {
      return code;
    }
    return result['name'];
  }
}
