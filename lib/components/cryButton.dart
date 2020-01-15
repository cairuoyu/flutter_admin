import 'package:flutter/material.dart';

class CryButton extends RaisedButton {
  CryButton({String text, onPressed})
      : super(
          child: Text(text),
          onPressed: onPressed,
        );
}
