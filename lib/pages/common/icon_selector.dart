import 'package:flutter/material.dart';
import 'package:flutter_admin/data/data_icon.dart';
import 'package:get/get.dart';

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
          Get.back<String>(result: e.key);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(e.value),
            SizedBox(height: 10),
            Text(e.key ?? ''),
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
