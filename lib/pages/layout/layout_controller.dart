import 'package:flutter_admin/enum/MenuDisplayType.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController {
  MenuDisplayType menuDisplayType;
  String currentOpenedMenuId;

  updateMenuDisplayType(v) {
    menuDisplayType = v;
    update();
  }
  updateCurrentOpendMenuId(v){
    currentOpenedMenuId = v;
    update();
  }
}
