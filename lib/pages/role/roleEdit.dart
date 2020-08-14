import 'package:flutter/material.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/form2/cryInput.dart';

class RoleEdit extends StatefulWidget {
  RoleEdit({Key key}) : super(key: key);

  @override
  _RoleEditState createState() => _RoleEditState();
}

class _RoleEditState extends State<RoleEdit> {
  @override
  Widget build(BuildContext context) {
    var form = Form(
      child: Column(
        children: [
          CryInput(
            label: 'name',
          ),
          CryButton(
            iconData: Icons.save,
            label: 'save',
            onPressed: () {},
          ),
        ],
      ),
    );
    return form;
    // return Container(child: Text('k'),);
  }
}
