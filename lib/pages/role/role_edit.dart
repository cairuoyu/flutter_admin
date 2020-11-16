import 'package:cry/form/cry_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/role_api.dart';
import 'package:cry/cry_button.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/response_body_api.dart';
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
    var buttonBar = ButtonBar(
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
            ResponseBodyApi responseBodyApi = await RoleApi.saveOrUpdate(_role);
            if (responseBodyApi.success) {
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
    );
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
        ],
      ),
    );
    var result = Scaffold(
      appBar: AppBar(
        title: Text(widget.role == null ? S.of(context).increase : S.of(context).modify),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [form],
        ),
      ),
      bottomNavigationBar: buttonBar,
    );
    return SizedBox(
      width: 500,
      height: 220,
      child: result,
    );
  }
}
