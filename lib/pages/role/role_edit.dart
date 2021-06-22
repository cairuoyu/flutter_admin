/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_buttons.dart';
import 'package:cry/form/cry_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/role_api.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/models/role.dart';
import 'package:cry/utils/cry_utils.dart';

class RoleEdit extends StatefulWidget {
  final Role? role;

  RoleEdit({Key? key, this.role}) : super(key: key);

  @override
  _RoleEditState createState() => _RoleEditState();
}

class _RoleEditState extends State<RoleEdit> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Role _role;

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
        CryButtons.save(context, save),
        CryButtons.cancel(context, () {
          Navigator.pop(context);
        })
      ],
    );
    var form = Form(
      key: formKey,
      child: Column(
        children: [
          CryInput(
            value: _role.name,
            label: S.of(context).name,
            onSaved: (v) {
              _role.name = v;
            },
            validator: (v) {
              return v!.isEmpty ? S.of(context).required : null;
            },
          ),
        ],
      ),
    );
    var result = Scaffold(
      appBar: AppBar(
        title: Text(widget.role == null ? S.of(context).add : S.of(context).modify),
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

  save() async {
    var form = formKey.currentState!;
    if (!form.validate()) {
      return;
    }
    form.save();
    ResponseBodyApi responseBodyApi = await RoleApi.saveOrUpdate(_role.toMap());
    if (responseBodyApi.success!) {
      Navigator.pop(context, true);
      CryUtils.message(S.of(context).success);
    }
  }
}
