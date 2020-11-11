import 'package:cry/cry_root.dart';
import 'package:cry/cry_toggle_buttons.dart';
import 'package:cry/model/configuration_model.dart';
import 'package:cry/vo/select_option_vo.dart';
import 'package:flutter/widgets.dart';

class LangSwitch extends StatefulWidget {
  LangSwitch({Key key}) : super(key: key);

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
      defaultValue: Configuration.of(context).locale,
      afterOnPress: (v) {
        Configuration configuration = Configuration.of(context).copyWith(locale: v);
        CryRootScope.updateConfiguration(context, configuration);
      },
    );
  }
}
