import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/constants/constant.dart';
import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:flutter_admin/pages/common/langSwitch.dart';
import 'package:flutter_admin/pages/register.dart';
import 'package:flutter_admin/utils/storeUtil.dart';
import 'package:flutter_admin/utils/localStorageUtil.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_admin/api/userApi.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [LangSwitch()],
          ),
          Center(child: appName),
          SizedBox(
            height: 20.0,
          ),
          _buildLoginForm(),
        ],
      ),
    );
  }

  Container _buildLoginForm() {
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
                            return v.isEmpty ? S.of(context).usernameRequired : null;
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
                            return v.isEmpty ? S.of(context).passwordRequired : null;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              S.of(context).register,
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () => _register(),
                          ),
                          FlatButton(
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
                  _login();
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                child: Text(S.of(context).login, style: TextStyle(color: Colors.white70, fontSize: 20)),
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => Register()),
    );
  }

  _login() {
    var form = formKey.currentState;
    if (!form.validate()) {
      return;
    }
    form.save();
    UserApi.login(user.toJson()).then((ResponeBodyApi responeBodyApi) async {
      if (responeBodyApi.success) {
        LocalStorageUtil.set(Constant.KEY_TOKEN, responeBodyApi.data);
        await StoreUtil.loadMenuData();
        String defaultPage = '/layout';
        if (StoreUtil.treeVOList.length > 0) {
          defaultPage = StoreUtil.treeVOList.first.data.url;
        }
        Navigator.pushNamed(context, defaultPage);
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
