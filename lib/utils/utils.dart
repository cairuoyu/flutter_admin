import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/components/cryDialog.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/data/data1.dart';
import 'package:flutter_admin/utils/localStorageUtil.dart';
import 'package:flutter_admin/utils/storeUtil.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static message(text) {
    BotToast.showText(text: text);
  }

  static isLogin() {
    return LocalStorageUtil.get(Constant.KEY_TOKEN) != null;
  }

  static logout() {
    LocalStorageUtil.set(Constant.KEY_TOKEN, null);
    StoreUtil.treeVOList = null;
    StoreUtil.treeVOOpened = [];
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
}
