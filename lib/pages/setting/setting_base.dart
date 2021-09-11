/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/9/3
/// @version: 1.0
/// @description:

import 'package:flutter/material.dart';
import 'package:flutter_admin/pages/setting/setting_default_tab.dart';

class SettingBase extends StatefulWidget {
  @override
  _SettingBaseState createState() => _SettingBaseState();
}

class _SettingBaseState extends State<SettingBase> {
  @override
  Widget build(BuildContext context) {
    var list = ExpansionPanelList.radio(
      initialOpenPanelValue: 1,
      children: [
        ExpansionPanelRadio(
          canTapOnHeader: true,
          value: 1,
          headerBuilder: (c, e) {
            return ListTile(
              title: Text("默认标签页配置"),
            );
          },
          body: SettingDefaultTab(),
        ),
        ExpansionPanelRadio(
          canTapOnHeader: true,
          value: 2,
          headerBuilder: (c, e) {
            return ListTile(
              title: Text("其它配置"),
            );
          },
          body: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('。。。'),
          ),),
        ),
      ],
    );
    var result = Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: list,
        ),
      ),
    );
    return result;
  }
}
