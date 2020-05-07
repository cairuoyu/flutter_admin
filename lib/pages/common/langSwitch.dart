import 'package:flutter/widgets.dart';
import 'package:flutter_admin/components/cryRoot.dart';
import 'package:flutter_admin/components/cryToggleButtons.dart';
import 'package:flutter_admin/vo/selectOptionVO.dart';

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
      afterOnPress: (v) {
        setState(() {
          CryRootScope.updateLocale(context, v);
        });
      },
    );
  }
}
