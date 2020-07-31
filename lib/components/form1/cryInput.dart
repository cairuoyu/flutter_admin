import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cryFormField.dart';

class CryInput extends CryFormField {
  CryInput({
    Key key,
    double width,
    String label,
    double labelWidth,
    String value,
    ValueChanged onChange,
    FormFieldSetter onSaved,
    FormFieldValidator<String> validator,
    bool enable,
  }) : super(
          key: key,
          width: width,
          label: label,
          labelWidth: labelWidth,
          builder: (state) {
            return TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(),
                enabled: enable ?? true,
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
