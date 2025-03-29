/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cry/utils.dart';

class Page404 extends StatelessWidget {
  const Page404({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text('你访问的页面不存在'),
            CryButton(
              iconData: Icons.arrow_back,
              label: '返回首页',
              onPressed: () {
                CryUtil.pushNamed('/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
