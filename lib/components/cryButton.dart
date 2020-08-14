import 'package:flutter/material.dart';

class CryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData iconData;
  final String tip;
  CryButton({this.label, this.iconData, this.onPressed, this.tip});

  @override
  Widget build(BuildContext context) {
    Widget result;
    if (iconData != null) {
      if (label == null) {
        result = IconButton(
          icon: Icon(iconData),
          onPressed: onPressed,
        );
      } else {
        result = RaisedButton.icon(
          icon: Icon(iconData),
          label: Text(this.label),
          onPressed: onPressed,
        );
      }
    } else {
      result = RaisedButton(
        child: Text(this.label ?? ''),
        onPressed: onPressed,
      );
    }
    if (tip != null) {
      result = Tooltip(
        child: result,
        message: tip,
      );
    }
    return result;
  }
}
