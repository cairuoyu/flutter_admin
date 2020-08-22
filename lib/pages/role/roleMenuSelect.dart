import 'package:flutter/material.dart';
import 'package:flutter_admin/api/RoleMenuApi.dart';
import 'package:flutter_admin/components/cryTransfer.dart';
import 'package:flutter_admin/models/index.dart' as model;
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/models/role.dart';
import 'package:flutter_admin/models/roleMenu.dart';
import 'package:flutter_admin/pages/role/roleMenuSelectList.dart';
import 'package:flutter_admin/utils/utils.dart';

class RoleMenuSelect extends StatefulWidget {
  RoleMenuSelect({Key key, this.role}) : super(key: key);
  final Role role;

  @override
  _RoleMenuSelectState createState() => _RoleMenuSelectState();
}

class _RoleMenuSelectState extends State<RoleMenuSelect> {
  final GlobalKey<RoleMenuSelectListState> tableKey1 = GlobalKey<RoleMenuSelectListState>();
  final GlobalKey<RoleMenuSelectListState> tableKey2 = GlobalKey<RoleMenuSelectListState>();
  model.Page page;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var table1 = RoleMenuSelectList(key: tableKey1, title: '未选择菜单', role: widget.role);
    var table2 = RoleMenuSelectList(key: tableKey2, title: '已选择菜单', role: widget.role, isSelected: true);
    var result = CryTransfer(
      left: table1,
      right: table2,
      toRight: () async {
        List<Menu> selectedList = tableKey1.currentState.getSelectedList();
        if (selectedList.isEmpty) {
          Utils.message('请选择【未选择菜单】');
          return;
        }
        List roleMenuList = selectedList.map((e) => RoleMenu(roleId: widget.role.id, menuId: e.id).toMap()).toList();
        await RoleMenuApi.saveBatch(roleMenuList);
        Utils.message('保存成功');
        tableKey1.currentState.query();
        tableKey2.currentState.query();
      },
      toLeft: () async {
        List<Menu> selectedList = tableKey2.currentState.getSelectedList();
        if (selectedList.isEmpty) {
          Utils.message('请选择【已选择菜单】');
          return;
        }
        List roleMenuList = selectedList.map((e) => RoleMenu(roleId: widget.role.id, menuId: e.id).toMap()).toList();
        await RoleMenuApi.removeBatch(roleMenuList);
        Utils.message('保存成功');
        tableKey1.currentState.query();
        tableKey2.currentState.query();
      },
    );

    return result;
  }
}
