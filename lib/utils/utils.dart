import 'package:bot_toast/bot_toast.dart';
import 'package:cry/cry_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/data/data_icon.dart';
import 'package:flutter_admin/enum/MenuDisplayType.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/models/tab_page.dart';
import 'package:flutter_admin/pages/layout/layout_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {

  static openTab(TabPage tabPage) {
    LayoutController layoutController = Get.find();
    var openedTabPageList = layoutController.openedTabPageList;
    layoutController.currentOpenedTabPageId = tabPage.id;
    int index = openedTabPageList.indexWhere((note) => note.id == tabPage.id);
    if (index > -1) {
      layoutController.tabController?.animateTo(index);
      return;
    }
    openedTabPageList.add(tabPage);
    layoutController.updateMenuOpend(openedTabPageList);
  }
  static closeTab(int index) {
    LayoutController layoutController = Get.find();
    var openedTabPageList = layoutController.openedTabPageList;
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

  static isLocalEn(BuildContext context) {
    return Get.locale?.languageCode == 'en';
  }

  static isMenuDisplayTypeDrawer(BuildContext context) {
    LayoutController layoutController = Get.find();
    return layoutController.menuDisplayType == MenuDisplayType.drawer;
  }

  static getThemeData(Color themeColor) {
    return ThemeData(
      primaryColor: themeColor,
      iconTheme: IconThemeData(color: themeColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: themeColor,
      ),
      buttonTheme: ButtonThemeData(buttonColor: themeColor),
    );
  }

  static message(text, {durationSeconds = 3}) {
    BotToast.showText(text: text, duration: Duration(seconds: durationSeconds));
  }

  static isLogin() {
    return GetStorage().hasData(Constant.KEY_TOKEN);
  }

  static logout() {
    GetStorage().remove(Constant.KEY_TOKEN);
    GetStorage().remove(Constant.KEY_MENU_LIST);
    GetStorage().remove(Constant.KEY_DICT_ITEM_LIST);
  }

  static launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static toPortal(BuildContext context, String message, String buttonText, String url) {
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
            FlatButton(
              color: Colors.lightBlue,
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

  static List<Menu> getMenuTree() {
    var data = GetStorage().read(Constant.KEY_MENU_LIST);
    return List.from(data).map((e) => Menu.fromMap(e)).toList();
  }
}
