import 'package:flutter/material.dart';

class CryRootScope extends InheritedWidget {
  CryRootScope(this.state, {Widget child}) : super(child: child);
  final CryRootState state;

  static CryRootScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CryRootScope>();
  }

  static uploadThemeColor(BuildContext context, Color value) {
    context.dependOnInheritedWidgetOfExactType<CryRootScope>().state.updateThemeColor(value);
  }

  static updateLocale(BuildContext context, String value) {
    context.dependOnInheritedWidgetOfExactType<CryRootScope>().state.updateLocal(value);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class CryRoot extends StatefulWidget {
  CryRoot(this.child, {Key key}) : super(key: key);
  final Widget child;

  @override
  CryRootState createState() => CryRootState();
}

class CryRootState extends State<CryRoot> {
  String locale = 'system';
  Color themeColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return CryRootScope(
      this,
      child: widget.child,
    );
  }

  updateLocal(String value) {
    setState(() {
      this.locale = value;
    });
  }

  updateThemeColor(Color value) {
    setState(() {
      themeColor = value;
    });
  }
}
