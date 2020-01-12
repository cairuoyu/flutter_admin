import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
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
    user.username = 'admin';
    user.password = '1';
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
                height: 450,
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
                      
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        
                        child: TextFormField(
                          initialValue: user.username,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "用户名",
                            hintStyle: TextStyle(color: Colors.black),
                            icon: Icon(
                              Icons.people,
                              color: Colors.blue,
                            ),
                          ),
                          onSaved: (v) {
                            user.username = v;
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                        
                        child: TextFormField(
                          initialValue: user.password,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "密码",
                            hintStyle: TextStyle(color: Colors.black),
                            icon: Icon(
                              Icons.lock,
                              color: Colors.blue,
                            ),
                          ),
                          onSaved: (v) {
                            user.password = v;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              "忘记密码",
                              style: TextStyle(color: Colors.black45),
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
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
            height: 370,
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 400,
              child: RaisedButton(
                onPressed: () {
                  login();
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                child: Text("登录", style: TextStyle(color: Colors.white70)),
                color: Colors.blue,
              ),
            ),
          ),
          Container(
            height: 420,
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
          // Wrap(
          //   children: <Widget>[Text(error)],
          // ),
        ],
      ),
    );
  }

  register() {
    
    BotToast.showText(text: '开发中...');
  }

  login() {
    formKey.currentState.save();
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
