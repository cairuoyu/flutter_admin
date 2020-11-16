import 'package:cry/cry_root.dart';
import 'package:cry/model/configuration_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/pages/common/lang_switch.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class LayoutSetting extends StatelessWidget {
  const LayoutSetting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var picker = BlockPicker(
      pickerColor: CryRootScope.of(context).state.configuration.themeColor,
      onColorChanged: (v) {
        Configuration configuration = Configuration.of(context).copyWith(themeColor: v);
        CryRootScope.updateConfiguration(context, configuration);
      },
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
            child: LangSwitch(),
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
