import 'package:flutter/material.dart';


void cryConfirm(BuildContext context, String content, onConfirm) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('信息'),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            child: const Text('取消'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: const Text('确定'),
            onPressed: onConfirm,
          ),
        ],
      );
    },
  );
}
cryDialog({
  BuildContext context,
  String title,
  Widget body,
  Future then,
  int width,
  int height,
}) {
  AppBar header = AppBar(
    title: Text(title),
  );
  return showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      
      
      child: Container(
        width: width ?? double.infinity,
        
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            header,
            body,
          ],
        ),
      ),
      
      
      
    ),
  );
}
