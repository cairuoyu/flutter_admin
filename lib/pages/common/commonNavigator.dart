/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:flutter/material.dart';

class CommonNavigator extends StatelessWidget {
  final Widget child;

  CommonNavigator(this.child);

  @override
  Widget build(BuildContext context) {
    var result = Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          return child;
        });
      },
    );
    return result;
  }
}
