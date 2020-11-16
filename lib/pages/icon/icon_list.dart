import 'package:flutter/material.dart';
import 'package:cry/cry_button.dart';

class IconList extends StatefulWidget {
  IconList({Key key}) : super(key: key);

  @override
  _IconListState createState() => _IconListState();
}

class _IconListState extends State<IconList> {
  @override
  Widget build(BuildContext context) {
    var a = CryButton(iconData: Icons.ac_unit);
    var b = CryButton(iconData: IconData(0xe558, fontFamily: 'MaterialIcons'));
    return ButtonBar(children: [a,b]);
  }
}
