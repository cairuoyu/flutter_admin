import 'package:flutter/material.dart';
import 'package:flutter_admin/enum/MenuDisplayType.dart';
import 'package:flutter_admin/models/configuration_model.dart';


class CryRoot extends StatefulWidget {
  CryRoot(
    this.child, {
    Key key,
    this.configuration = const Configuration(
      locale: 'zh',
      themeColor: Colors.blue,
      menuDisplayType: MenuDisplayType.drawer,
    ),
  }) : super(key: key);
  final Widget child;
  final Configuration configuration;

  @override
  CryRootState createState() => CryRootState();
}

class CryRootState extends State<CryRoot> {
  Configuration configuration;

  @override
  void initState() {
    this.configuration = widget.configuration;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CryRootScope(
      this,
      child: widget.child,
    );
  }

  updateConfiguration(Configuration configuration) {
    setState(() {
      this.configuration = configuration;
    });
  }
}

class CryRootScope extends InheritedWidget {
  CryRootScope(this.state, {Widget child}) : super(child: child);
  final CryRootState state;

  static CryRootScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CryRootScope>();
  }

  static updateConfiguration(BuildContext context, Configuration configuration) {
    context.dependOnInheritedWidgetOfExactType<CryRootScope>().state.updateConfiguration(configuration);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
