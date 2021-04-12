import 'package:cry/cry_dialog.dart';
import 'package:cry/vo/tree_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/constants/enum.dart';
import 'package:flutter_admin/data/data_icon.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/models/tab_page.dart';
import 'package:flutter_admin/models/user_info.dart';
import 'package:flutter_admin/pages/layout/layout_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static openTab(TabPage tabPage) {
    LayoutController layoutController = Get.find();
    List<TabPage> openedTabPageList = layoutController.openedTabPageList;
    layoutController.currentOpenedTabPageId = tabPage.id;
    int index = openedTabPageList.indexWhere((note) => note.id == tabPage.id);
    if (index > -1) {
      layoutController.tabController?.animateTo(index);
      return;
    }
    openedTabPageList.add(tabPage);
    layoutController.updateMenuOpend(openedTabPageList);
  }

  static closeTab(TabPage tabPage) {
    LayoutController layoutController = Get.find();
    List<TabPage> openedTabPageList = layoutController.openedTabPageList;
    int index = openedTabPageList.indexWhere((note) => note.id == tabPage.id);
    closeTabByIndex(index);
  }

  static closeTabByIndex(int index) {
    LayoutController layoutController = Get.find();
    List<TabPage> openedTabPageList = layoutController.openedTabPageList;
    if (index >= openedTabPageList.length) {
      return;
    }
    TabPage tabPage = openedTabPageList[index];
    openedTabPageList.removeAt(index);
    var length = openedTabPageList.length;
    if (length == 0) {
      layoutController.currentOpenedTabPageId = null;
    } else if (layoutController.currentOpenedTabPageId == tabPage.id) {
      layoutController.currentOpenedTabPageId = openedTabPageList.first.id;
    }
    layoutController.updateMenuOpend(openedTabPageList);
  }

  static closeAllTab() {
    LayoutController layoutController = Get.find();
    List<TabPage> openedTabPageList = layoutController.openedTabPageList;
    openedTabPageList.clear();
    layoutController.currentOpenedTabPageId = null;
    layoutController.updateMenuOpend(openedTabPageList);
  }

  static closeOtherTab(TabPage tabPage) {
    LayoutController layoutController = Get.find();
    List<TabPage> openedTabPageList = layoutController.openedTabPageList;
    openedTabPageList.removeWhere((element) => element.id != tabPage.id);
    layoutController.currentOpenedTabPageId = tabPage.id;
    layoutController.updateMenuOpend(openedTabPageList);
  }

  static closeAllToTheRightTab(TabPage tabPage) {
    LayoutController layoutController = Get.find();
    List<TabPage> openedTabPageList = layoutController.openedTabPageList;
    int index = openedTabPageList.indexWhere((note) => note.id == tabPage.id);
    openedTabPageList.removeRange(index + 1, openedTabPageList.length);
    layoutController.currentOpenedTabPageId = tabPage.id;
    layoutController.updateMenuOpend(openedTabPageList);
  }

  static closeAllToTheLeftTab(TabPage tabPage) {
    LayoutController layoutController = Get.find();
    List<TabPage> openedTabPageList = layoutController.openedTabPageList;
    int index = openedTabPageList.indexWhere((note) => note.id == tabPage.id);
    openedTabPageList.removeRange(0, index);
    layoutController.currentOpenedTabPageId = tabPage.id;
    layoutController.updateMenuOpend(openedTabPageList);
  }

  static isLocalEn(BuildContext context) {
    return (Get.locale ?? Get.deviceLocale).languageCode == 'en';
  }

  static isMenuDisplayTypeDrawer(BuildContext context) {
    LayoutController layoutController = Get.find();
    return layoutController.menuDisplayType == MenuDisplayType.drawer;
  }

  static getThemeData({Color themeColor, String fontFamily, bool isDark = false}) {
    LayoutController layoutController = Get.find();
    if (fontFamily != null) {
      layoutController.fontFamily = fontFamily;
    }
    if (themeColor == null) {
      themeColor = Get.theme?.primaryColor ?? Colors.blue;
    }
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: themeColor,
      iconTheme: IconThemeData(color: themeColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: themeColor,
      ),
      buttonTheme: ButtonThemeData(buttonColor: themeColor),
      fontFamily: layoutController.fontFamily,
    );
  }

  static loading() {
    Get.dialog(Center(child: CircularProgressIndicator()));
  }

  static message(message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static isLogin() {
    return GetStorage().hasData(Constant.KEY_TOKEN);
  }

  static logout() {
    GetStorage().remove(Constant.KEY_TOKEN);
    GetStorage().remove(Constant.KEY_MENU_LIST);
    GetStorage().remove(Constant.KEY_DICT_ITEM_LIST);
    GetStorage().remove(Constant.KEY_CURRENT_USER_INFO);
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

  static toIconData(String icon) {
    if (icon == null || icon == '') {
      return Icons.menu;
    }
    // IconData iconData = IconData(int.parse(icon), fontFamily: 'MaterialIcons');
    return iconMap[icon] ?? Icons.menu;
  }

  static UserInfo getCurrentUserInfo() {
    var data = GetStorage().read(Constant.KEY_CURRENT_USER_INFO);
    return data == null ? UserInfo() : UserInfo.fromMap(data);
  }

  static List<Menu> getMenuTree() {
    var data = GetStorage().read(Constant.KEY_MENU_LIST);
    return data == null ? [] : List.from(data).map((e) => Menu.fromMap(e)).toList();
  }

  static bool isCurrentOpenedMenu(List<TreeVO<Menu>> data) {
    LayoutController layoutController = Get.find();
    for (var treeVO in data) {
      if (treeVO.children != null && treeVO.children.length > 0) {
        return isCurrentOpenedMenu(treeVO.children);
      }
      return layoutController.currentOpenedTabPageId == treeVO.data.id;
    }
    return false;
  }
}
