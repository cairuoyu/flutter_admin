import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Test1State();
  }
}

class Test1State extends State {
  String value1 = 'test';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(value1)),
    );
  }
}
