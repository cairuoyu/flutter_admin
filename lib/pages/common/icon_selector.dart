/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:flutter/material.dart';
import 'package:flutter_admin/data/data_icon.dart';

class IconSelector extends StatefulWidget {
  @override
  _IconSelectorState createState() => _IconSelectorState();
}

class _IconSelectorState extends State<IconSelector> {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = iconMap.entries.map((e) {
      var result = InkWell(
        onTap: () {
          Navigator.pop(context, e.key);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(e.value),
            SizedBox(height: 10),
            Text(e.key),
          ],
        ),
      );
      return result;
    }).toList();
    GridView gv = GridView.extent(
      maxCrossAxisExtent: 100,
      children: list,
    );
    var result = Scaffold(
      appBar: AppBar(
        title: Text('Icon'),
      ),
      body: Center(
        child: Container(
          child: gv,
        ),
      ),
    );
    return result;
  }
}
