
import 'package:flutter_admin/vo/selectOptionVO.dart';

class DictUtil{
  static getDictName(String value, List<SelectOptionVO> list, {defaultValue = ''}) {
    if (value == null) {
      return defaultValue;
    }
    SelectOptionVO result = list.firstWhere((v) {
      return v.value == value;
    });
    if (result == null) {
      return value;
    }
    return result.label;
  }
}
