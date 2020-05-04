import 'package:flutter/material.dart';
import '../generated/l10n.dart';

void cryConfirm(BuildContext context, String content, onConfirm) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(S.of(context).information),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            child: Text(S.of(context).cancel),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(S.of(context).confirm),
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
  double width,
  double height,
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
