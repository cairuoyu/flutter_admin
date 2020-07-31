import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CryFormField extends StatefulWidget {
  final double width;
  final Function builder;

  CryFormField({
    Key key,
    this.builder,
    this.width,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CryFormFieldState();
}

class CryFormFieldState extends State<CryFormField> {
  didChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: widget.width ?? double.infinity,
      child: widget.builder(this),
    );
  }
}
