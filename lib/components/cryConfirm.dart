import 'package:flutter/cupertino.dart';
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
