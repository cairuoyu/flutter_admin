/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:flutter/material.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_admin/data/data_font.dart';

class FontSelector extends StatefulWidget {
  @override
  _FontSelectorState createState() => _FontSelectorState();
}

class _FontSelectorState extends State<FontSelector> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: S.of(context).font,
        icon: Icon(
          Icons.font_download,
          color: Colors.blue,
        ),
      ),
      value: Utils.currentFontFamily,
      items: fontFamilyMap.entries.map((e) {
        return DropdownMenuItem<String>(
          value: e.key,
          child: Text(
            e.value,
            style: TextStyle(fontFamily: e.key, fontSize: 10),
          ),
        );
      }).toList(),
      onChanged: (v) {
        Get.changeTheme(Utils.getThemeData(fontFamily: v));
        setState(() {});
      },
    );
  }
}
