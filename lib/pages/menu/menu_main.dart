import 'package:flutter/material.dart';
import 'package:flutter_admin/models/subsystem.dart';
import 'package:flutter_admin/pages/subsystem/subsystem_list.dart';

import 'menu_list.dart';

class MenuMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SubsystemList(
      openSubsystemBuilder: (Subsystem subsystem) {
        return MenuList(
          subsystem: subsystem,
        );
      },
    );
  }
}
