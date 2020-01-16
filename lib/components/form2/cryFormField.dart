import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CryFormField extends StatefulWidget {
  final String label;
  final String value;
  final int width;
  final ValueChanged onChange;
  final Function builder;

  CryFormField({Key key, this.label, this.value, this.onChange, this.builder, this.width}) : super(key: key);

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
      width: widget.width ?? 300,
      child: widget.builder(this),
    );
  }
}
