import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    if (Get.isLogEnable) {
      print(this.toString() + '----initState');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Get.isLogEnable) {
      print(this.toString() + '--build');
    }
    return super.build(context);
  }

  @override
  bool get wantKeepAlive => true;
}
