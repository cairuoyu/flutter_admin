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
