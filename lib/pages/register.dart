/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description: 注册

import 'package:flutter/material.dart';
import 'package:flutter_admin/api/user_api.dart';
import 'package:cry/cry.dart';
import 'package:flutter_admin/models/user.dart';
import 'package:cry/utils/cry_utils.dart';
import '../generated/l10n.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User user = new User();
  String? password2 = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(),
      child: Scaffold(
        body: _buildPageContent(),
      ),
    );
  }

  Widget _buildPageContent() {
    var appName = Text(
      S.of(context).register,
      style: TextStyle(fontSize: 16, color: Colors.green),
      textScaleFactor: 3.2,
    );
    return Container(
      color: Colors.blue.shade100,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 60.0,
          ),
          Center(child: appName),
          SizedBox(
            height: 20.0,
          ),
          _buildRegisterForm(),
        ],
      ),
    );
  }

  _buildRegisterForm() {
    var form = Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: S.of(context).username,
              ),
              onSaved: (v) {
                user.userName = v;
              },
              validator: (v) {
                return v!.isEmpty ? S.of(context).usernameRequired : null;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: S.of(context).password,
              ),
              onSaved: (v) {
                user.password = v;
              },
              validator: (v) {
                return v!.isEmpty ? S.of(context).passwordRequired : null;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                // helperText: '两次密码必须一致',
                labelText: S.of(context).confirmPassword,
              ),
              onSaved: (v) {
                password2 = v;
              },
              validator: (v) {
                return password2 == user.password ? null : S.of(context).passwordMismatch;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: Text(
                  S.of(context).haveAccountLogin,
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: _login,
              )
            ],
          ),
          SizedBox(height: 20),
          Container(
            // height: 620,
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 400,
              child: ElevatedButton(
                onPressed: () {
                  _register();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0))),
                ),
                child: Text(S.of(context).register, style: TextStyle(color: Colors.white70, fontSize: 20)),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          color: Colors.white,
        ),
        child: form,
      ),
    );
  }

  _login() {
    Cry.pushNamed('/login');
  }

  _register() {
    var form = formKey.currentState!;
    form.save();
    if (form.validate()) {
      UserApi.register(user.toMap()).then((v) {
        if (!v.success!) {
          return;
        }
        _login();
        CryUtils.message(S.of(context).registerSuccess);
      });
    }
  }
}
