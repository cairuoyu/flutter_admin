/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_button_bar.dart';
import 'package:cry/cry_buttons.dart';
import 'package:cry/cry_tree_table.dart';
import 'package:cry/utils/tree_util.dart';
import 'package:cry/vo/tree_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/utils/utils.dart';

class MenuTableTree extends StatefulWidget {
  final List<TreeVO<Menu>> treeVOList;
  final Function(Menu)? onEdit;
  final Function(List<String>)? onDelete;

  MenuTableTree({
    required this.treeVOList,
    this.onEdit,
    this.onDelete,
  });

  @override
  _MenuTableTreeState createState() => _MenuTableTreeState();
}

class _MenuTableTreeState extends State<MenuTableTree> {
  @override
  void initState() {
    super.initState();
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
      columnData: columnData,
      data: widget.treeVOList,
      onSelected: (v) => _onSelected(v),
      getRowOper: (TreeVO<Menu> v, TreeVO<Menu>? parent) => _getRowOper(v, parent),
      tableWidth: 1500,
      selectType: CryTreeTableSelectType.childrenCascade,
    );
    var result = Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: _getToolbars(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [treeTable],
        ),
      ),
    );
    return result;
  }

  _getToolbars() {
    var selected = TreeUtil.getSelected(widget.treeVOList);
    var result = CryButtonBar(
      children: <Widget>[
        CryButtons.add(context, () => widget.onEdit!(Menu())),
        CryButtons.delete(
          context,
          selected.length >= 1
              ? () {
                  List<String> ids = selected.map((e) => e.data!.id!).toList();
                  widget.onDelete!(ids);
                }
              : null,
        ),
      ],
    );
    return result;
  }

  List<Widget> _getRowOper(TreeVO<Menu> vo, TreeVO<Menu>? parent) {
    List<Widget> columnList = [];
    Menu menu = vo.data!;
    columnList.add(
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () => widget.onEdit!(Menu(pname: vo.data!.name, pid: vo.data!.id)),
      ),
    );
    columnList.add(
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          if (parent != null) {
            menu.pname = parent.data!.name;
          }
          widget.onEdit!(menu);
        },
      ),
    );
    return columnList;
  }

  _onSelected(TreeVO<Menu>? v) {
    setState(() {});
  }
}
