import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CryButton1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CryButton1State();
  }
}

class CryButton1State extends State {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      child: Text('kk'),
      onPressed: () {},
    );
  }
}
