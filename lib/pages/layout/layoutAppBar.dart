import 'package:flutter/material.dart';
import 'package:flutter_admin/pages/login.dart';
import 'package:flutter_admin/utils/utils.dart';

class LayoutAppBar extends AppBar {
  LayoutAppBar(BuildContext context, {Key key, int type, openSetting})
      : super(
          key: key,
          automaticallyImplyLeading: false,
          leading: Tooltip(
              message: 'Home',
              child: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Utils.launchURL('http://www.cairuoyu.com');
                },
              )),
          title: Text("FLUTTER_ADMIN"),
          actions: <Widget>[
            Tooltip(
              message: '设置',
              child: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  openSetting();
                },
              ),
            ),
            Tooltip(
              message: type == 1 ? '无路由模式' : '路由模式',
              child: IconButton(
                icon: Icon(Icons.link),
                onPressed: () {
                  Navigator.pushNamed(context, type == 1 ? '/layoutNoRoutes' : '/');
                },
              ),
            ),
            Tooltip(
              message: 'Code',
              child: IconButton(
                icon: Icon(Icons.code),
                onPressed: () {
                  Utils.launchURL("https://github.com/cairuoyu/flutter_admin");
                },
              ),
            ),
            Tooltip(
              message: '我的信息',
              child: IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/userInfoMine');
                },
              ),
            ),
            Tooltip(
              message: 'Logout',
              child: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Utils.logout();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => Login()),
                  );
                },
              ),
            ),
          ],
        );
}
