import 'package:cry/cry_toggle_buttons.dart';
import 'package:cry/vo/select_option_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_admin/enum/MenuDisplayType.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/pages/common/lang_switch.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class LayoutSetting extends StatelessWidget {
  LayoutSetting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var picker = BlockPicker(
      pickerColor: Get.theme.primaryColor,
      onColorChanged: (v) {
        Get.changeTheme(Utils.getThemeData(v));
      },
    );
    var menuDisplayType = CryToggleButtons(
      [
        SelectOptionVO(value: MenuDisplayType.drawer, label: S.of(context).drawer),
        SelectOptionVO(value: MenuDisplayType.side, label: S.of(context).side),
      ],
      defaultValue: MenuDisplayType.side,
      afterOnPress: (Object v) {},
    );
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(S.of(context).mySettings),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            padding: EdgeInsets.all(10),
            child: Row(children: [
              SizedBox(width: 100, child: Text(S.of(context).menuDisplay)),
              menuDisplayType,
            ]),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            padding: EdgeInsets.all(10),
            child: Row(children: [
              SizedBox(width: 100, child: Text(S.of(context).language)),
              LangSwitch(),
            ]),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            padding: EdgeInsets.all(5),
            child: picker,
          ),
        ],
      ),
    );
  }
}
