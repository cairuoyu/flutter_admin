import 'package:flutter/material.dart';
import 'package:flutter_admin/enum/MenuDisplayType.dart';
import 'package:flutter_admin/models/tab_page.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController {
  TabController tabController;
  MenuDisplayType menuDisplayType;
  String currentOpenedTabPageId;
  List<TabPage> openedTabPageList = [];

  init() {
    currentOpenedTabPageId = null;
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
