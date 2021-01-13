import 'package:flutter/material.dart';
import 'package:flutter_admin/models/role.dart';
import 'package:flutter_admin/models/subsystem.dart';
import 'package:flutter_admin/pages/role/role_menu_select.dart';
import 'package:flutter_admin/pages/subsystem/subsystem_list.dart';

class RoleSubsystemList extends StatelessWidget {
  final Role role;

  RoleSubsystemList({this.role});

  @override
  Widget build(BuildContext context) {
    return SubsystemList(
      openSubsystemBuilder: (Subsystem subsystem) {
        return RoleMenuSelect(
          role: role,
          subsystem: subsystem,
        );
      },
    );
  }
}
