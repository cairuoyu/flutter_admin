import 'package:flutter/material.dart';

class OnlyText extends StatelessWidget {
  final String text;

  const OnlyText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
