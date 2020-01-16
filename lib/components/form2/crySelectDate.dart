import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'cryFormField.dart';

class CrySelectDate extends CryFormField {
  final String label;
  final ValueChanged onChange;
  final FormFieldSetter onSaved;
  final BuildContext context;

  CrySelectDate({Key key, this.context, this.label, String value, this.onChange, this.onSaved})
      : super(
          key: key,
          builder: (CryFormFieldState state) {
            return TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                labelText: label,
              ),
              controller: TextEditingController(text: value),
              onChanged: (v) {
                if (onChange != null) {
                  onChange(v);
                }
              },
              onTap: () async {
                final DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101),
                );
                value = DateFormat("yyyy-MM-dd").format(picked);
                state.didChange();
              },
              onSaved: onSaved,
            );
          },
        );
}
