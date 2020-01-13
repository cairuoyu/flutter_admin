import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_admin/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/pages/register.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
        child: MaterialApp(
      title: 'FLUTTER_ADMIN',
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Test1(),
      // home: Curd1(),
      // home: Register(),
      home: Login(),
      // home: Layout1(),
    ));
  }
}
