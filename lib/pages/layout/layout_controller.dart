import 'package:flutter/material.dart';
import 'package:flutter_admin/constants/enum.dart';
import 'package:flutter_admin/models/tab_page.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController {
  TabController tabController;
  MenuDisplayType menuDisplayType = MenuDisplayType.side;
  String currentOpenedTabPageId;
  List<TabPage> openedTabPageList = [];
  String fontFamily = 'bradhitc';

  init() {
    currentOpenedTabPageId = null;
    openedTabPageList = [];
  }

  updateMenuDisplayType(v) {
    menuDisplayType = v;
    update();
  }

  updateCurrentOpendMenuId(v) {
    currentOpenedTabPageId = v;
    update();
  }

  updateMenuOpend(v) {
    openedTabPageList = v;
    update();
  }
}
