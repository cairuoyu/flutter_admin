import 'package:bot_toast/bot_toast.dart';
import 'package:cry/cry_tree_table.dart';
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
import 'package:flutter_admin/utils/tree_util.dart';
import 'package:flutter_admin/utils/utils.dart';

class RoleMenuSelect extends StatefulWidget {
  final Function onEdit;
  final VoidCallback reloadData;
  final List<TreeVO<Menu>> treeVOList;
  final Role role;
  final Subsystem subsystem;

  RoleMenuSelect({
    this.subsystem,
    this.onEdit,
    this.treeVOList,
    this.reloadData,
    @required this.role,
  });

  @override
  _RoleMenuSelectState createState() => _RoleMenuSelectState();
}

class _RoleMenuSelectState extends State<RoleMenuSelect> {
  List<TreeVO<Menu>> data;
  final GlobalKey<CryTreeTableState> treeTableKey = GlobalKey<CryTreeTableState>();

  @override
  void initState() {
    super.initState();
    this._loadData();
  }

  @override
  Widget build(BuildContext context) {
    List<CryTreeTableColumnData> columnData = [
      CryTreeTableColumnData(S.of(context).name, (Menu v) => v.name),
      CryTreeTableColumnData(S.of(context).englishName, (Menu v) => v.nameEn),
      CryTreeTableColumnData('URL', (Menu v) => v.url),
      CryTreeTableColumnData(S.of(context).sequenceNumber, (Menu v) => v.orderBy?.toString(), width: 180),
      CryTreeTableColumnData(S.of(context).remarks, (Menu v) => v.remark, width: 300)
    ];

    var treeTable = CryTreeTable<Menu>(
      key: treeTableKey,
      columnData: columnData,
      data: data,
      onSelected: (v) => _onSelected(v),
      tableWidth: 1300,
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
    BotToast.showLoading();
    List<Menu> selectedList = treeTableKey.currentState.getSelectedData();
    List roleMenuList = selectedList.map((e) => RoleMenu(roleId: widget.role.id, menuId: e.id).toMap()).toList();
    ResponseBodyApi res = await RoleMenuApi.saveBatch({'roleId': widget.role.id, 'subsystemId': widget.subsystem.id, 'roleMenuList': roleMenuList});
    if (res.success) {
      BotToast.closeAllLoading();
      Utils.message(S.of(context).saved);
      Navigator.pop(context);
    }
  }

  _loadData() async {
    ResponseBodyApi responseBodyApi = await RoleApi.getMenu(RequestBodyApi(params: {'roleId': widget.role.id, 'subsystemId': widget.subsystem.id}).toMap());
    var data = responseBodyApi.data;
    List<Menu> list = List.from(data).map((e) => Menu.fromMap(e)).toList();
    this.data = TreeUtil.toTreeVOList(list);
    this.setState(() {});
  }

  _onSelected(TreeVO<Menu> v) {
    setState(() {});
  }
}
