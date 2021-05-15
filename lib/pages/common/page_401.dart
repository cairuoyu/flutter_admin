import 'package:flutter/material.dart';
import 'package:cry/cry_button.dart';
import 'package:cry/routes/cry.dart';
import 'package:flutter_admin/utils/utils.dart';

class Page401 extends StatelessWidget {
  const Page401({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('你没有此菜单权限，请用管理员（admin/admin）登录后在角色管理功能配置'),
          CryButton(
            iconData: Icons.check,
            label: '重新登录',
            onPressed: () {
              Utils.logout();
              Cry.pushNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
