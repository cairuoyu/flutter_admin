/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description: 注册

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cry/common/application_context.dart';
import 'package:cry/common/face_recognition.dart';
import 'package:cry/common/face_service_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/user_api.dart';
import 'package:cry/cry.dart';
import 'package:flutter_admin/models/user.dart';
import 'package:cry/utils/cry_utils.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../generated/l10n.dart';
import 'package:dio/dio.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User user = new User();
  String? password2 = "";
  bool isFaceRecognition = false;
  String? imagePath;
  CameraImage? cameraImage;
  Face? face;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(),
      child: Scaffold(
        body: isFaceRecognition
            ? FaceRecognition(
                onFountFace: (CameraImage cameraImage, String imagePath, List<Face> faces) {
                  setState(() {
                    this.isFaceRecognition = false;
                    this.imagePath = imagePath;
                    this.cameraImage = cameraImage;
                    this.face = faces[0];
                  });
                },
                onBack: () {
                  setState(() {
                    this.isFaceRecognition = false;
                  });
                },
              )
            : _buildPageContent(),
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
              controller: TextEditingController(text: user.userName),
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
              controller: TextEditingController(text: user.password),
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
              controller: TextEditingController(text: password2),
              onSaved: (v) {
                password2 = v;
              },
              validator: (v) {
                return password2 == user.password ? null : S.of(context).passwordMismatch;
              },
            ),
          ),
          if (this.imagePath != null) SizedBox(width: 100, child: Image.file(File(this.imagePath!))),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                children: [
                  if (ApplicationContext.instance.cameras.length > 0)
                    TextButton(
                      child: Text(
                        '注册人脸',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        setState(() {
                          formKey.currentState!.save();
                          this.isFaceRecognition = true;
                        });
                      },
                    ),
                  TextButton(
                    child: Text(
                      S.of(context).haveAccountLogin,
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: _login,
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            // height: 620,
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 400,
              child: FilledButton(
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
      String faceData = '';
      Map<String, dynamic> map = user.toMap();
      map['file'] = null;
      if (this.cameraImage != null && this.face != null) {
        faceData = FaceService().toData(this.cameraImage!, this.face!);
        map['face'] = faceData;

        var value = File(this.imagePath!).readAsBytesSync();
        var file = MultipartFile.fromBytes(value, filename: 'test.png'); //todo
        map['file'] = file;
      }
      FormData formData = FormData.fromMap(map);

      UserApi.register(formData).then((v) {
        if (!v.success!) {
          return;
        }
        _login();
        CryUtils.message(S.of(context).registerSuccess);
      });
    }
  }
}
