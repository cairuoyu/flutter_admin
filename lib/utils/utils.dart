/// @author: cairuoyu
/// @Copyright: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description: 常用工具类

import 'package:cry/cry_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cry/cry.dart';
import 'package:flutter_admin/common/routes.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/constants/enum.dart';
import 'package:flutter_admin/data/data_icon.dart';
import 'package:flutter_admin/models/tab_page.dart';
import 'package:flutter_admin/pages/layout/layout_controller.dart';
import 'package:flutter_admin/utils/store_util.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static openTab(String url) {
    Cry.popAndPushNamed(url);
  }

  static closeTab(TabPage? tabPage) {
    List<TabPage?> openedTabPageList = StoreUtil.readOpenedTabPageList();
    int index = openedTabPageList.indexWhere((note) => note!.id == tabPage!.id);
    if (index >= openedTabPageList.length) {
      return;
    }
    openedTabPageList.removeAt(index);
    var length = openedTabPageList.length;
    String? url;
    if (length == 0) {
      StoreUtil.writeCurrentOpenedTabPageId(null);
      url = '/';
    } else if (StoreUtil.readCurrentOpenedTabPageId() == tabPage!.id) {
      StoreUtil.writeCurrentOpenedTabPageId(openedTabPageList.first!.id);
      url = openedTabPageList.first!.url;
    } else {
      url = openedTabPageList.first!.url;
    }
    StoreUtil.writeOpenedTabPageList(openedTabPageList);
    Cry.popAndPushNamed(url!);
  }

  static closeAllTab() {
    StoreUtil.init();
    Cry.popAndPushNamed('/');
  }

  static closeOtherTab(TabPage tabPage) {
    List<TabPage?> openedTabPageList = StoreUtil.readOpenedTabPageList();
    openedTabPageList.removeWhere((element) => element!.id != tabPage.id && !Routes.defaultTabPage.contains(element));
    StoreUtil.writeCurrentOpenedTabPageId(tabPage.id);
    StoreUtil.writeOpenedTabPageList(openedTabPageList);
    Cry.popAndPushNamed(tabPage.url!);
  }

  static closeAllToTheRightTab(TabPage tabPage) {
    List<TabPage?> openedTabPageList = StoreUtil.readOpenedTabPageList();
    int index = openedTabPageList.indexWhere((note) => note!.id == tabPage.id);
    openedTabPageList.removeWhere((element) => openedTabPageList.indexOf(element) > index && !Routes.defaultTabPage.contains(element));
    StoreUtil.writeCurrentOpenedTabPageId(tabPage.id);
    StoreUtil.writeOpenedTabPageList(openedTabPageList);
    Cry.popAndPushNamed(tabPage.url!);
  }

  static closeAllToTheLeftTab(TabPage tabPage) {
    List<TabPage?> openedTabPageList = StoreUtil.readOpenedTabPageList();
    int index = openedTabPageList.indexWhere((note) => note!.id == tabPage.id);
    openedTabPageList.removeWhere((element) => openedTabPageList.indexOf(element) < index && !Routes.defaultTabPage.contains(element));
    StoreUtil.writeCurrentOpenedTabPageId(tabPage.id);
    StoreUtil.writeOpenedTabPageList(openedTabPageList);
    Cry.popAndPushNamed(tabPage.url!);
  }

  static isLocalEn(BuildContext context) {
    return (Get.locale ?? Get.deviceLocale)!.languageCode == 'en';
  }

  static isMenuDisplayTypeDrawer(BuildContext context) {
    LayoutController layoutController = Get.find();
    return layoutController.menuDisplayType == MenuDisplayType.drawer;
  }

  static getThemeData({Color? themeColor, String? fontFamily, bool isDark = false}) {
    LayoutController layoutController = Get.find();
    if (fontFamily != null) {
      layoutController.fontFamily = fontFamily;
    }
    if (themeColor == null) {
      themeColor = Get.theme.primaryColor;
    }
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: themeColor,
      iconTheme: IconThemeData(color: themeColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: themeColor,
      ),
      buttonTheme: ButtonThemeData(buttonColor: themeColor),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(themeColor))),
      fontFamily: layoutController.fontFamily,
    );
  }

  static isLogin() {
    return StoreUtil.hasData(Constant.KEY_TOKEN);
  }

  static logout() {
    StoreUtil.cleanAll();
  }

  static launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static toPortal(BuildContext context, String message, String buttonText, {String url = "http://www.cairuoyu.com/flutter_portal"}) {
    cryAlertWidget(
      context,
      Container(
        height: 100,
        child: Column(
          children: [
            Text(message),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text(buttonText),
              onPressed: () {
                Utils.launchURL(url);
              },
            ),
          ],
        ),
      ),
    );
  }

  static toIconData(String? icon) {
    if (icon == null || icon == '') {
      return Icons.menu;
    }
    // IconData iconData = IconData(int.parse(icon), fontFamily: 'MaterialIcons');
    return iconMap[icon] ?? Icons.menu;
  }

// static bool isCurrentOpenedMenu(List<TreeVO<Menu>> data) {
//   for (var treeVO in data) {
//     if (treeVO.children != null && treeVO.children.length > 0) {
//       return isCurrentOpenedMenu(treeVO.children);
//     }
//     return StoreUtil.readCurrentOpenedTabPageId() == treeVO.data.id;
//   }
//   return false;
// }
}
