import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/models/index.dart';

class Test1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Test1State();
  }
}

class Test1State extends State {
  UserInfo formData = UserInfo();
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
