import 'package:flutter/material.dart';

class MyTest extends StatefulWidget {
  final int n;

  MyTest(this.n);

  @override
  _MyTestState createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  @override
  void initState() {
    print(widget.n.toString() + '--myTest--initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.n.toString() + '--myTest--build');
    var body = Center(child: Text('myTest' + widget.n.toString()));
    return Scaffold(
      body: body,
    );
  }

  @override
  void dispose() {
    print(widget.n.toString() + '--myTest--dispose');
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print(widget.n.toString() + '--myTest--didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    print(widget.n.toString() + '--myTest--deactivate');
    super.deactivate();
  }

  @override
  void didUpdateWidget(MyTest oldWidget) {
    print(widget.n.toString() + '--myTest--didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }
}
