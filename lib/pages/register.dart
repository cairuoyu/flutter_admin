import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/userApi.dart';
import 'package:flutter_admin/pages/login.dart';
import 'package:flutter_admin/models/index.dart';
import 'package:flutter_admin/models/user.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterState();
}

class RegisterState extends State {
  static final String path = "lib/src/pages/login/login2.dart";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User user = new User();
  String password2 = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageContent(),
    );
  }

  Widget buildPageContent() {
    var appName = Text(
      "注册",
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
          buildRegisterForm(),
        ],
      ),
    );
  }

  buildRegisterForm() {
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '用户名',
              ),
              onSaved: (v) {
                user.userName = v;
              },
              validator: (v) {
                return v.isEmpty ? '用户名必填' : null;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '密码',
              ),
              onSaved: (v) {
                user.password = v;
              },
              validator: (v) {
                return v.isEmpty ? '密码必填' : null;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // helperText: '两次密码必须一致',
                labelText: '确认密码',
              ),
              onSaved: (v) {
                password2 = v;
              },
              validator: (v) {
                return password2 == user.password ? null : '两次密码必须一致';
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                  child: Text(
                    "已有账号，登录",
                    style: TextStyle(color: Colors.black45),
                  ),
                  onPressed: () => login())
            ],
          ),
          Container(
            // height: 620,
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 400,
              child: RaisedButton(
                onPressed: () {
                  register();
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                child: Text("注册", style: TextStyle(color: Colors.white70)),
                color: Colors.blue,
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

  login() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Login()));
  }

  register() {
    var form = formKey.currentState;
    form.save();
    if (form.validate()) {
      UserApi.register(user.toJson()).then((v) {
        login();
        BotToast.showText(text: '注册成功');
      });
    }
  }
}
