import 'package:flutter/material.dart';

class TreeVO<T>{
  T data;
  List<TreeVO<T>> children = [];
  bool isExpanded = false;
  IconData icon;
  bool checked = false;

  TreeVO({this.data});
}