import 'package:flutter_admin/enum/MenuDisplayType.dart';
import 'package:get/get.dart';

class LayoutSettingController extends GetxController {
  MenuDisplayType menuDisplayType;

  updateMenuDisplayType(v) {
    menuDisplayType = v;
    update();
  }
}
