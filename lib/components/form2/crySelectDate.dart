import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiver/strings.dart';

import 'cryFormField.dart';

class CrySelectDate extends CryFormField {
  CrySelectDate({
    Key key,
    String value,
    String label,
    ValueChanged onChange,
    FormFieldSetter onSaved,
    BuildContext context,
  }) : super(
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
                DateTime valueDt = isBlank(value) ? DateTime.now() : DateTime.parse(value);
                final DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: valueDt,
                  firstDate: DateTime(1900, 1),
                  lastDate: DateTime(2021, 12),
                );
                if (picked != null) {
                  value = DateFormat("yyyy-MM-dd").format(picked);
                }
                state.didChange();
              },
              onSaved: onSaved,
            );
          },
        );
}
