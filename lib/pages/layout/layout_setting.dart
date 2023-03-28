/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_toggle_buttons.dart';
import 'package:cry/utils/adaptive_util.dart';
import 'package:cry/vo/select_option_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/constants/enum.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/pages/common/font_selector.dart';
import 'package:flutter_admin/pages/common/lang_switch.dart';
import 'package:flutter_admin/pages/layout/layout_controller.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class LayoutSetting extends StatelessWidget {
  LayoutSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LayoutController layoutController = Get.find();
    var picker = BlockPicker(
      pickerColor: context.theme.primaryColor,
      onColorChanged: (v) {
        Get.changeTheme(Utils.getThemeData(themeColor: v));
      },
    );
    var menuDisplayType = CryToggleButtons(
      [
        SelectOptionVO(value: MenuDisplayType.drawer, label: S.of(context).drawer),
        SelectOptionVO(value: MenuDisplayType.side, label: S.of(context).side),
      ],
      defaultValue: layoutController.menuDisplayType,
      afterOnPress: (Object? v) {
        layoutController.updateMenuDisplayType(v);
      },
    );
    var themeMode = Switch(
      onChanged: (nightMode) => {
        Get.changeTheme(context.isDarkMode
            ? Utils.getThemeData(
                brightness: Brightness.light,
              )
            : Utils.getThemeData(
                brightness: Brightness.dark,
              ))
      },
      value: context.isDarkMode,
    );
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(S.of(context).mySettings),
            decoration: BoxDecoration(
              color: Get.theme.primaryColor,
            ),
          ),
          ListTile(
            title: Text(S.of(context).language),
            trailing: LangSwitch(),
          ),
          Divider(thickness: 1),
          if (isDisplayDesktop(context))
            ListTile(
              title: Text(S.of(context).menuDisplay),
              trailing: menuDisplayType,
            ),
          if (isDisplayDesktop(context)) Divider(thickness: 1),
          ListTile(
            title: Text(S.of(context).nightMode),
            trailing: themeMode,
          ),
          Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: FontSelector(),
          ),
          Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: picker,
          ),
          Divider(thickness: 1),
        ],
      ),
    );
  }
}
