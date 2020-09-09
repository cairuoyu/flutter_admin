import 'package:flutter/material.dart';

class TreeVO<T extends TreeData> {
  TreeVO({this.data});

  T data;
  TreeVO<T> parent;
  List<TreeVO<T>> children = [];
  bool isExpanded = false;
  IconData icon = Icons.menu;
  bool checked = false;
}

class TreeData {
  TreeData(this.id, this.pid);
  bool checked;
  String id;
  String pid;
}
