import 'package:flutter/material.dart';
import 'package:flutter_admin/pages/layout/layout_controller.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_admin/data/data_font.dart';

class FontSelector extends StatefulWidget {
  @override
  _FontSelectorState createState() => _FontSelectorState();
}

class _FontSelectorState extends State<FontSelector> {
  String currentFontFamily;

  @override
  Widget build(BuildContext context) {
    LayoutController layoutController = Get.find();
    var result = PopupMenuButton(
      tooltip: '选择字体',
      child: Container(
        child: Text(fontFamilyMap[currentFontFamily ?? layoutController.fontFamily]),
        padding: EdgeInsets.all(10),
      ),
      initialValue: currentFontFamily ?? layoutController.fontFamily,
      onSelected: (v) {
        Get.changeTheme(Utils.getThemeData(fontFamily: v));
        setState(() {
          currentFontFamily = v;
        });
      },
      itemBuilder: (context) => fontFamilyMap.entries
          .map(
            (e) => PopupMenuItem(
              value: e.key,
              child: ListTile(
                title: Text(
                  e.value,
                  style: TextStyle(fontFamily: e.key),
                ),
              ),
            ),
          )
          .toList(),
    );
    return result;
  }
}
