/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_transfer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/role_user_api.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/role.dart';
import 'package:flutter_admin/models/role_user.dart';
import 'package:flutter_admin/models/user_info.dart';
import 'package:flutter_admin/pages/role/role_user_select_list.dart';
import 'package:cry/utils/cry_utils.dart';

class RoleUserSelect extends StatefulWidget {
  RoleUserSelect({Key? key, this.role}) : super(key: key);
  final Role? role;

  @override
  _RoleUserSelectState createState() => _RoleUserSelectState();
}

class _RoleUserSelectState extends State<RoleUserSelect> {
  final GlobalKey<RoleUserSelectListState> tableKey1 = GlobalKey<RoleUserSelectListState>();
  final GlobalKey<RoleUserSelectListState> tableKey2 = GlobalKey<RoleUserSelectListState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var table1 = RoleUserSelectList(key: tableKey1, title: S.of(context).unselectedUsers, role: widget.role);
    var table2 = RoleUserSelectList(key: tableKey2, title: S.of(context).selectedUsers, role: widget.role, isSelected: true);
    var transfer = CryTransfer(
      left: table1,
      right: table2,
      toRight: () async {
        List<UserInfo> selectedList = tableKey1.currentState!.getSelectedList();
        if (selectedList.isEmpty) {
          CryUtils.message(S.of(context).selectUnselectedUsers);
          return;
        }
        List roleUserList = selectedList.map((e) => RoleUser(userId: e.userId, roleId: widget.role!.id).toMap()).toList();
        await RoleUserApi.saveBatch(roleUserList);
        CryUtils.message(S.of(context).saved);
        tableKey1.currentState!.query();
        tableKey2.currentState!.query();
      },
      toLeft: () async {
        List<UserInfo> selectedList = tableKey2.currentState!.getSelectedList();
        if (selectedList.isEmpty) {
          CryUtils.message(S.of(context).selectSelectedUsers);
          return;
        }
        List roleUserList = selectedList.map((e) => RoleUser(roleId: widget.role!.id, userId: e.userId).toMap()).toList();
        await RoleUserApi.removeBatch(roleUserList);
        CryUtils.message(S.of(context).saved);
        tableKey1.currentState!.query();
        tableKey2.currentState!.query();
      },
    );

    var result = Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).selectUsers),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [transfer],
        ),
      ),
    );
    return result;
  }
}
