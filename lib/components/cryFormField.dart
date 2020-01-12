import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CryFormField extends StatefulWidget {
  final String label;
  final String value;
  final ValueChanged onChange;
  final Function builder;

  CryFormField({Key key, this.label, this.value, this.onChange, this.builder})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => CryFormFieldState();
}

class CryFormFieldState extends State<CryFormField> {
  didChange(){
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: UnconstrainedBox(
        
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 100,
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Align(
                  child: Text(widget.label),
                  alignment: Alignment.centerRight,
                ),
              ),
            ),
            SizedBox(
              width: 300,
              
              
                child: widget.builder(this),
              
            ),
          ],
        ),
      ),
    );
  }
}
