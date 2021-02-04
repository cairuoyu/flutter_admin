import 'package:flutter_admin/enum/MenuDisplayType.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController {
  MenuDisplayType menuDisplayType;
  String currentOpenedMenuId;
  List<Menu> menuOpened = [];

  init() {
    currentOpenedMenuId = null;
  }

  updateMenuDisplayType(v) {
    menuDisplayType = v;
    update();
  }

  updateCurrentOpendMenuId(v) {
    currentOpenedMenuId = v;
    update();
  }

  updateMenuOpend(v) {
    menuOpened = v;
    update();
  }
}
