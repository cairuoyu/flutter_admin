import 'package:flutter/material.dart';

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
