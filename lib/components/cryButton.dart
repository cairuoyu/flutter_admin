import 'package:flutter/material.dart';

class CryButton extends RaisedButton {
  CryButton({String text, onPressed})
      : super(
          color: Colors.blue,
          child: Text(text),
          onPressed: onPressed,
        );
}
