/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_toggle_buttons.dart';
import 'package:cry/vo/select_option_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LangSwitch extends StatefulWidget {
  LangSwitch({Key? key}) : super(key: key);

  @override
  LangSwitchState createState() => LangSwitchState();
}

class LangSwitchState extends State<LangSwitch> {
  @override
  Widget build(BuildContext context) {
    return CryToggleButtons(
      [
        SelectOptionVO(value: 'en', label: 'english'),
        SelectOptionVO(value: 'zh', label: '中文'),
      ],
      defaultValue: (Get.locale ?? Get.deviceLocale)!.languageCode,
      afterOnPress: (v) {
        Get.updateLocale(Locale(v));
      },
    );
  }
}
