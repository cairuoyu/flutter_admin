import 'package:flutter/material.dart';

class TreeVO<T extends TreeData> {
  TreeVO({this.data});

  T data;
  List<TreeVO<T>> children = [];
  bool isExpanded = false;
  IconData icon = Icons.menu;
  bool checked = false;
}

class TreeData {
  TreeData(this.id, this.pid);
  String id;
  String pid;
}
