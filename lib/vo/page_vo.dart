

import 'package:flutter/widgets.dart';

class PageVO {
  const PageVO({this.id, this.widget, this.children, this.icon, this.title});
  final String id;
  final IconData icon;
  final String title;
  final List<PageVO> children;
  final Widget widget;
}