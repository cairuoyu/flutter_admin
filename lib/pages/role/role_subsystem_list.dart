/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:flutter/material.dart';
import 'package:flutter_admin/models/role.dart';
import 'package:flutter_admin/models/subsystem.dart';
import 'package:flutter_admin/pages/role/role_menu_select.dart';
import 'package:flutter_admin/pages/subsystem/subsystem_list.dart';

class RoleSubsystemList extends StatelessWidget {
  final Role? role;

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
