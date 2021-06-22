/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

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
