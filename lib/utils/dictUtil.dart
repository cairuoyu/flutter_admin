import 'package:flutter_admin/utils/storeUtil.dart';
import 'package:flutter_admin/vo/selectOptionVO.dart';

class DictUtil {
  static List<SelectOptionVO> getDictSelectOptionList(String dictCode) {
    return StoreUtil.instance.dictSelectMap[dictCode];
  }

  static getDictName(String value, List<SelectOptionVO> list, {defaultValue = ''}) {
    if (value == null) {
      return defaultValue;
    }
    SelectOptionVO result = list.firstWhere((v) {
      return v.value == value;
    }, orElse: () {
      return null;
    });
    if (result == null) {
      return value;
    }
    return result.label;
  }
}
