import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeepAliveWrapper extends StatefulWidget {
  final Widget child;

  const KeepAliveWrapper({Key key, this.child}) : super(key: key);

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    if (Get.isLogEnable) {
      print(widget.child.toStringShort() + '--initState');
    }
    super.initState();
  }

  @override
  void dispose() {
    if (Get.isLogEnable) {
      print(widget.child.toStringShort() + '--disponse');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Get.isLogEnable) {
      print(widget.child.toStringShort() + '--build');
    }
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
