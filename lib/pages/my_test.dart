import 'package:flutter/material.dart';

class MyTest extends StatefulWidget {
  @override
  _MyTestState createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var body = Center(child: Text('test'));
    return Scaffold(
      body: body,
    );
  }
}
