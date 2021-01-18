import 'package:flutter/material.dart';
import 'package:flutter_admin/pages/dept/dept_list.dart';

class DeptMain extends StatefulWidget {
  @override
  _DeptMainState createState() => _DeptMainState();
}

class _DeptMainState extends State<DeptMain> {
  @override
  Widget build(BuildContext context) {
    return DeptList();
  }
}
