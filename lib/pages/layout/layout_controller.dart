/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:flutter_admin/constants/enum.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController {
  MenuDisplayType? menuDisplayType = MenuDisplayType.side;
  bool isMaximize = false;

  toggleMaximize() {
    this.isMaximize = !this.isMaximize;
    this.update();
  }

  updateMenuDisplayType(v) {
    menuDisplayType = v;
    update();
  }
}
