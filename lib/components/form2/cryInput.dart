import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cryFormField.dart';

class CryInput extends CryFormField {
  final String label;
  final int width;
  final ValueChanged onChange;
  final FormFieldSetter onSaved;
  final FormFieldValidator<String> validator;

  CryInput({Key key, this.width, this.label, String value, this.onChange, this.onSaved, this.validator})
      : super(
          key: key,
          builder: (state) {
            return TextFormField(
              decoration: InputDecoration(
                labelText: label,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
              controller: TextEditingController(text: value),
              onChanged: (v) {
                if (onChange != null) {
                  onChange(v);
                }
              },
              onSaved: onSaved,
              validator: validator,
            );
          },
        );
}
