import 'package:flutter/material.dart';

class CryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData iconData;
  CryButton({this.label, this.iconData, this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (iconData != null) {
      return RaisedButton.icon(
        icon: Icon(iconData),
        label: Text(this.label),
        onPressed: onPressed,
      );
    } else {
      return RaisedButton(
        child: Text(this.label),
        onPressed: onPressed,
      );
    }
  }
}
