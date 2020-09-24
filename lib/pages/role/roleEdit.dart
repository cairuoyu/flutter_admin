import 'package:flutter/material.dart';
import 'package:flutter_admin/api/roleApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/form2/cryInput.dart';
import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:flutter_admin/models/role.dart';

class RoleEdit extends StatefulWidget {
  final Role role;
  RoleEdit({Key key, this.role}) : super(key: key);

  @override
  _RoleEditState createState() => _RoleEditState();
}

class _RoleEditState extends State<RoleEdit> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Role _role;
  @override
  void initState() {
    super.initState();
    _role = widget.role ?? Role();
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Column(
        children: [
          CryInput(
            value: _role.name,
            label: '名称',
            onSaved: (v) {
              _role.name = v;
            },
            validator: (v) {
              return v.isEmpty ? '请填写名称' : null;
            },
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              CryButton(
                iconData: Icons.save,
                label: '保存',
                onPressed: () async {
                  var form = formKey.currentState;
                  if (!form.validate()) {
                    return;
                  }
                  form.save();
                  ResponeBodyApi responeBodyApi = await RoleApi.saveOrUpdate(_role);
                  if (responeBodyApi.success) {
                    Navigator.pop(context, true);
                  }
                },
              ),
              CryButton(
                iconData: Icons.cancel,
                label: '取消',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
    return form;
  }
}
