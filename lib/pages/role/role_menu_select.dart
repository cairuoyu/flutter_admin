/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_tree_table.dart';
import 'package:cry/utils/tree_util.dart';
import 'package:cry/vo/tree_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/role_api.dart';
import 'package:flutter_admin/api/role_menu_api.dart';
import 'package:cry/cry_button.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/models/role.dart';
import 'package:flutter_admin/models/role_menu.dart';
import 'package:flutter_admin/models/subsystem.dart';
import 'package:cry/utils/cry_utils.dart';
import 'package:flutter_admin/utils/utils.dart';

class RoleMenuSelect extends StatefulWidget {
  final Function? onEdit;
  final VoidCallback? reloadData;
  final List<TreeVO<Menu>>? treeVOList;
  final Role? role;
  final Subsystem? subsystem;

  RoleMenuSelect({
    this.subsystem,
    this.onEdit,
    this.treeVOList,
    this.reloadData,
    required this.role,
  });

  @override
  _RoleMenuSelectState createState() => _RoleMenuSelectState();
}

class _RoleMenuSelectState extends State<RoleMenuSelect> {
  List<TreeVO<Menu>>? data;
  final GlobalKey<CryTreeTableState> treeTableKey = GlobalKey<CryTreeTableState>();

  @override
  void initState() {
    super.initState();
    this._loadData();
  }

  @override
  Widget build(BuildContext context) {
    List<CryTreeTableColumnData> columnData = [
      CryTreeTableColumnData(label: S.of(context).name, getCell: (Menu v) => Text(v.name!)),
      CryTreeTableColumnData(label: S.of(context).englishName, getCell: (Menu v) => Text(v.nameEn!)),
      CryTreeTableColumnData(label: 'URL', getCell: (Menu v) => Text(v.url!)),
      CryTreeTableColumnData(label: 'Icon', getCell: (Menu v) => Icon(Utils.toIconData(v.icon))),
      CryTreeTableColumnData(label: S.of(context).sequenceNumber, getCell: (Menu v) => Text(v.orderBy.toString()), width: 180),
      CryTreeTableColumnData(label: S.of(context).remarks, getCell: (Menu v) => Text(v.remark!), width: 300)
    ];

    var treeTable = CryTreeTable<Menu>(
      key: treeTableKey,
      columnData: columnData,
      data: data,
      onSelected: (v) => _onSelected(v),
      tableWidth: 1500,
      selectType: CryTreeTableSelectType.parentCascadeTrue,
    );
    var result = Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).selectMenus),
        actions: [
          CryButton(
            iconData: Icons.save,
            label: S.of(context).save,
            onPressed: () => save(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [treeTable],
        ),
      ),
    );
    return result;
  }

  save() async {
    List<Menu?> selectedList = treeTableKey.currentState!.getSelectedData() as List<Menu?>;
    List roleMenuList = selectedList.map((e) => RoleMenu(roleId: widget.role!.id, menuId: e!.id).toMap()).toList();
    ResponseBodyApi res = await RoleMenuApi.saveBatch({'roleId': widget.role!.id, 'subsystemId': widget.subsystem!.id, 'roleMenuList': roleMenuList});
    if (res.success!) {
      CryUtils.message(S.of(context).saved);
    }
  }

  _loadData() async {
    ResponseBodyApi responseBodyApi = await RoleApi.getMenu(RequestBodyApi(params: {'roleId': widget.role!.id, 'subsystemId': widget.subsystem!.id}).toMap());
    var data = responseBodyApi.data;
    List<Menu> list = List.from(data).map((e) => Menu.fromMap(e)).toList();
    this.data = TreeUtil.toTreeVOList(list);
    this.setState(() {});
  }

  _onSelected(TreeVO<Menu>? v) {
    setState(() {});
  }
}
