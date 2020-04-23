import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cryFormField.dart';

class CryInput extends CryFormField {
  final String label;
  final double width;
  final double labelWidth;
  final ValueChanged onChange;
  final FormFieldSetter onSaved;
  final FormFieldValidator<String> validator;

  CryInput(
      {Key key,
      this.label,
      String value,
      this.onChange,
      this.onSaved,
      this.validator,
      this.width,
      this.labelWidth})
      : super(
          key: key,
          builder: (state) {
            return TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: value),
              onChanged: (v) {
                if (onChange != null) {
                  onChange(v);
                }
              },
              onSaved: (v) {
                if (onSaved != null) {
                  onSaved(v);
                }
              },
              validator: validator,
            );
          },
        );
}
