/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description: 登录

import 'package:flutter/material.dart';
import 'package:cry/cry.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/pages/common/lang_switch.dart';
import 'package:flutter_admin/utils/store_util.dart';
import 'package:flutter_admin/api/user_api.dart';
import 'package:flutter_admin/models/user.dart';
import '../generated/l10n.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User user = new User();
  String error = "";
  FocusNode focusNodeUserName = FocusNode();
  FocusNode focusNodePassword = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNodeUserName.requestFocus();
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
      "FLUTTER_ADMIN",
      style: TextStyle(fontSize: 16, color: Colors.blue),
      textScaleFactor: 3.2,
    );
    return Container(
      color: Colors.cyan.shade100,
      child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [LangSwitch()],
          ),
          Center(child: appName),
          SizedBox(height: 20.0),
          _buildLoginForm(),
          SizedBox(height: 20.0),
          Column(
            children: [
              Text(S.of(context).admin + '：admin/admin'),
              Text(S.of(context).loginTip),
            ],
          )
        ],
      ),
    );
  }

  Container _buildLoginForm() {
    return Container(
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: 500,
              height: 360,
              margin: EdgeInsets.only(top: 40),
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
                        focusNode: focusNodeUserName,
                        initialValue: user.userName,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: S.of(context).username,
                          icon: Icon(
                            Icons.people,
                            color: Colors.blue,
                          ),
                        ),
                        onSaved: (v) {
                          user.userName = v;
                        },
                        validator: (v) {
                          return v!.isEmpty ? S.of(context).usernameRequired : null;
                        },
                        onFieldSubmitted: (v) {
                          focusNodePassword.requestFocus();
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: TextFormField(
                        focusNode: focusNodePassword,
                        obscureText: true,
                        initialValue: user.password,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: S.of(context).password,
                          icon: Icon(
                            Icons.lock,
                            color: Colors.blue,
                          ),
                        ),
                        onSaved: (v) {
                          user.password = v;
                        },
                        validator: (v) {
                          return v!.isEmpty ? S.of(context).passwordRequired : null;
                        },
                        onFieldSubmitted: (v) {
                          _login();
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: Text(
                            S.of(context).register,
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: _register,
                        ),
                        TextButton(
                          child: Text(
                            S.of(context).forgetPassword,
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
            height: 360,
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 420,
              child: ElevatedButton(
                onPressed: _login,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0))),
                ),
                child: Text(S.of(context).login, style: TextStyle(color: Colors.white70, fontSize: 20)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _register() {
    Cry.pushNamed('/register');
  }

  _login() async {
    var form = formKey.currentState!;
    if (!form.validate()) {
      return;
    }
    form.save();

    ResponseBodyApi responseBodyApi = await UserApi.login(user.toMap());
    if (!responseBodyApi.success!) {
      focusNodePassword.requestFocus();
      return;
    }
    StoreUtil.write(Constant.KEY_TOKEN, responseBodyApi.data[Constant.KEY_TOKEN]);
    StoreUtil.write(Constant.KEY_CURRENT_USER_INFO, responseBodyApi.data[Constant.KEY_CURRENT_USER_INFO]);
    await StoreUtil.loadDict();
    await StoreUtil.loadSubsystem();
    await StoreUtil.loadMenuData();
    await StoreUtil.loadDefaultTabs();
    StoreUtil.init();

    Cry.pushNamed('/');
  }

}
