import 'package:flutter/material.dart';
import 'package:cry/cry_button.dart';

class Page404 extends StatelessWidget {
  const Page404({Key key}) : super(key: key);

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
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
