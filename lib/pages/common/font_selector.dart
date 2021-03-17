import 'package:flutter/material.dart';
import 'package:flutter_admin/pages/layout/layout_controller.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get/get.dart';

class FontSelector extends StatefulWidget {
  @override
  _FontSelectorState createState() => _FontSelectorState();
}

class _FontSelectorState extends State<FontSelector> {
  String currentFontFamily;

  List<String> fontFamilyList = [
    'rockSalt',
    'agencry',
    'bradhitc',
    'fzytk',
  ];

  @override
  Widget build(BuildContext context) {
    LayoutController layoutController = Get.find();
    var result = PopupMenuButton(
      tooltip: '选择字体',
      child: Text(currentFontFamily ?? layoutController.fontFamily),
      initialValue: currentFontFamily ?? layoutController.fontFamily,
      onSelected: (v) {
        Get.changeTheme(Utils.getThemeData(fontFamily: v));
        setState(() {
          currentFontFamily = v;
        });
      },
      itemBuilder: (context) => fontFamilyList
          .map(
            (e) => PopupMenuItem(
              value: e,
              child: ListTile(
                title: Text(e),
              ),
            ),
          )
          .toList(),
    );
    return result;
  }
}
