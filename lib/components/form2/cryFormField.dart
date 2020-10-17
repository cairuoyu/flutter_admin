import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CryFormField extends StatefulWidget {
  final double width;
  final double padding;
  final Function builder;

  CryFormField({
    Key key,
    this.builder,
    this.width,
    this.padding,
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
      padding: EdgeInsets.all(widget.padding ?? 20.0),
      width: widget.width ?? double.infinity,
      child: widget.builder(this),
    );
  }
}
