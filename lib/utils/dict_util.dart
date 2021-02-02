import 'package:cry/vo/select_option_vo.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:get_storage/get_storage.dart';

class DictUtil {
  static List<SelectOptionVO> getDictSelectOptionList(String dictCode) {
    var data = GetStorage().read(Constant.KEY_DICT_ITEM_LIST);
    List list = Map.from(data)[dictCode];
    var a = list.map((e) => SelectOptionVO(value: e['code'], label: e['name'])).toList();
    return a;
  }

  static String getDictItemName(String code, String dictCode, {defaultValue = ''}) {
    if (code == null) {
      return defaultValue;
    }
    var data = GetStorage().read(Constant.KEY_DICT_ITEM_LIST);
    List list = Map.from(data)[dictCode];
    Map result = list.firstWhere((v) {
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
