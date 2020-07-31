import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'cryFormField.dart';

class CryInput extends CryFormField {
  CryInput({
    Key key,
    double width,
    String label,
    String value,
    ValueChanged onChange,
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
    bool enable,
    List<TextInputFormatter> inputFormatters,
  }) : super(
          key: key,
          width: width,
          builder: (CryFormFieldState state) {
            return TextFormField(
              decoration: InputDecoration(
                enabled: enable ?? true,
                labelText: label,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
              controller: TextEditingController(text: value),
              inputFormatters: inputFormatters ?? [],
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
