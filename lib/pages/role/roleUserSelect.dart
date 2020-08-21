import 'package:flutter/material.dart';
import 'package:flutter_admin/api/RoleUserApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/models/index.dart' as model;
import 'package:flutter_admin/models/role.dart';
import 'package:flutter_admin/models/roleUser.dart';
import 'package:flutter_admin/models/userInfo.dart';
import 'package:flutter_admin/pages/role/roleUserSelectList.dart';

class RoleUserSelect extends StatefulWidget {
  RoleUserSelect({Key key, this.role}) : super(key: key);
  final Role role;

  @override
  _RoleUserSelectState createState() => _RoleUserSelectState();
}

class _RoleUserSelectState extends State<RoleUserSelect> {
  final GlobalKey<RoleUserSelectListState> tableKey1 = GlobalKey<RoleUserSelectListState>();
  final GlobalKey<RoleUserSelectListState> tableKey2 = GlobalKey<RoleUserSelectListState>();
  model.Page page;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var table1 = RoleUserSelectList(key: tableKey1, role: widget.role);
    var table2 = RoleUserSelectList(key: tableKey2, role: widget.role, isSelected: true);
    var buttonBar = Container(
      width: 60,
      child: ButtonBar(
        children: [
          CryButton(
            iconData: Icons.arrow_right,
            onPressed: () async {
              List<UserInfo> selectedList = tableKey1.currentState.getSelectedList();
              List roleUserList = selectedList.map((e) {
                return RoleUser(userId: e.userId, roleId: widget.role.id).toMap();
              }).toList();
              await RoleUserApi.saveBatch(roleUserList);
              tableKey1.currentState.query();
              tableKey2.currentState.query();
            },
          ),
          CryButton(
            iconData: Icons.arrow_left,
            onPressed: () async {
              List<UserInfo> selectedList = tableKey2.currentState.getSelectedList();
              List roleUserList = selectedList.map((e) => RoleUser(roleId: widget.role.id, userId: e.userId).toMap()).toList();
              await RoleUserApi.removeBatch(roleUserList);
              tableKey1.currentState.query();
              tableKey2.currentState.query();
            },
          ),
        ],
      ),
    );
    var a = Expanded(
      child: Row(
        children: [
          table1,
          buttonBar,
          table2,
        ],
      ),
    );

    return a;
  }
}
