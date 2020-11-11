import 'package:cry/vo/select_option_vo.dart';
import 'package:flutter_admin/models/dictItem.dart';
import 'package:flutter_admin/utils/storeUtil.dart';

class DictUtil {
  static List<SelectOptionVO> getDictSelectOptionList(String dictCode) {
    return StoreUtil.instance.dictSelectMap[dictCode];
  }

  static getDictItemName(String code, String dictCode, {defaultValue = ''}) {
    if (code == null) {
      return defaultValue;
    }
    List<DictItem> list = StoreUtil.instance.dictItemMap[dictCode];
    DictItem result = list.firstWhere((v) {
      return v.code == code;
    }, orElse: () {
      return null;
    });
    if (result == null) {
      return code;
    }
    return result.name;
  }
}
