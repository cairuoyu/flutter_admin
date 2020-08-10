import 'package:flutter/material.dart';
import 'package:flutter_admin/api/menuDemoApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/cryDialog.dart';
import 'package:flutter_admin/components/cryTreeTable.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/utils/treeUtil.dart';
import 'package:flutter_admin/vo/treeVO.dart';

class MenuMenu extends StatefulWidget {
  final bool expand;
  final Function onEdit;
  final VoidCallback reloadData;
  final List<TreeVO<Menu>> treeVOList;
  MenuMenu({this.expand = true, this.onEdit, this.treeVOList, this.reloadData});
  @override
  _MenuMenuState createState() => _MenuMenuState();
}

class _MenuMenuState extends State<MenuMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CryTreeTableColumnData> columnData = [
      CryTreeTableColumnData('名称', (Menu v) => v.name),
      CryTreeTableColumnData('英文名', (Menu v) => v.nameEn),
      CryTreeTableColumnData('URL', (Menu v) => v.url),
      CryTreeTableColumnData('顺序号', (Menu v) => v.orderBy?.toString(), width: 80),
      CryTreeTableColumnData('备注', (Menu v) => v.remark, width: 300),
    ];
    var result = CryTreeTable(
      columnData: columnData,
      data: widget.treeVOList,
      toolbars: _getToolbars(),
      onSelected: (v) => _onSelected(v),
      getRowOper: (TreeVO<Menu> v, TreeVO<Menu> parent) => _getRowOper(v, parent),
      tableWidth: 1300,
      width: widget.expand ? 1300 : 400,
    );
    return result;
  }

  _getToolbars() {
    var selected = TreeUtil.getSelected(widget.treeVOList);
    var result = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        CryButton(
          iconData: Icons.add,
          label: '添加菜单',
          onPressed: () => widget.onEdit(Menu()),
        ),
        CryButton(
          iconData: Icons.delete,
          label: '删除',
          onPressed: selected.length >= 1
              ? () {
                  cryConfirm(context, S.of(context).confirmDelete, () async {
                    List ids = selected.map((e) => e.data.id).toList();
                    await MenuDemoApi.removeByIds(ids);
                    widget.reloadData();
                    Navigator.of(context).pop();
                  });
                }
              : null,
        ),
      ],
    );
    return result;
  }

  List<Widget> _getRowOper(TreeVO<Menu> vo, TreeVO<Menu> parent) {
    List<Widget> columnList = [];
    Menu menu = vo.data;
    columnList.add(
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () => widget.onEdit(Menu(pname: vo.data.name, pid: vo.data.id)),
      ),
    );
    columnList.add(
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          if (parent != null) {
            menu.pname = parent.data.name;
          }
          widget.onEdit(menu);
        },
      ),
    );
    return columnList;
  }

  _onSelected(TreeVO<Menu> v) {
    setState(() {});
  }
}
