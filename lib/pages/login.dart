import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/pages/register.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_admin/api/userApi.dart';
import 'package:flutter_admin/models/index.dart';
import 'package:flutter_admin/models/user.dart';
import 'package:flutter_admin/utils/globalUtil.dart';

import 'layout/layout1.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State {
  static final String path = "lib/src/pages/login/login2.dart";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User user = new User();
  String error = "";

  @override
  void initState() {
    super.initState();
    // user.userName = 'admin';
    // user.password = '1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageContent(),
    );
  }

  Widget buildPageContent() {
    var appName = Text(
      "FLUTTER_ADMIN",
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
          buildLoginForm(),
        ],
      ),
    );
  }

  Container buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          Center(
            child: ClipPath(
              clipper: WaveClipperTwo(reverse: true),
              child: Container(
                width: 500,
                height: 400,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  color: Colors.white,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 40),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: TextFormField(
                          initialValue: user.userName,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '用户名',
                            icon: Icon(
                              Icons.people,
                              color: Colors.blue,
                            ),
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
                          initialValue: user.password,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '密码',
                            icon: Icon(
                              Icons.lock,
                              color: Colors.blue,
                            ),
                          ),
                          onSaved: (v) {
                            user.password = v;
                          },
                          validator: (v) {
                            return v.isEmpty ? '密码必填' : null;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              "注册新账号",
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () => register(),
                          ),
                          FlatButton(
                            child: Text(
                              "忘记密码",
                              style: TextStyle(color: Colors.black45),
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.blue.shade600,
                child: Icon(Icons.person),
              ),
            ],
          ),
          Container(
            height: 380,
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 420,
              child: RaisedButton(
                onPressed: () {
                  login();
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                child: Text("登录", style: TextStyle(color: Colors.white70, fontSize: 20)),
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  register() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Register()));
  }

  login() {
    var form = formKey.currentState;
    if (!form.validate()) {
      return;
    }
    form.save();
    UserApi.login(user.toJson()).then((ResponeBodyApi responeBodyApi) {
      if (responeBodyApi.success) {
        GlobalUtil.token = responeBodyApi.data;
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Layout1()));
      } else {
        this.error = responeBodyApi.message;
        BotToast.showText(text: this.error);
        setState(() {});
      }
    }).catchError((e) {
      error = e;
      setState(() {});
    });
  }
}
