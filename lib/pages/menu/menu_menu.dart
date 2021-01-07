import 'package:cry/cry_buttons.dart';
import 'package:cry/cry_tree_table.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:cry/vo/tree_vo.dart';
import 'package:flutter/material.dart';
import 'package:cry/cry_dialog.dart';
import 'package:flutter_admin/api/menu_api.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/utils/tree_util.dart';

class MenuMenu extends StatefulWidget {
  final double width;
  final Function onEdit;
  final VoidCallback reloadData;
  final List<TreeVO<Menu>> treeVOList;
  final String subsystemId;

  MenuMenu({
    this.width,
    this.onEdit,
    this.treeVOList,
    this.reloadData,
    this.subsystemId,
  });

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
      CryTreeTableColumnData(S.of(context).name, (Menu v) => v.name),
      CryTreeTableColumnData(S.of(context).englishName, (Menu v) => v.nameEn),
      CryTreeTableColumnData('URL', (Menu v) => v.url),
      CryTreeTableColumnData(S.of(context).sequenceNumber, (Menu v) => v.orderBy?.toString(), width: 180),
      CryTreeTableColumnData(S.of(context).remarks, (Menu v) => v.remark, width: 300)
    ];
    var treeTable = CryTreeTable(
      columnData: columnData,
      data: widget.treeVOList,
      onSelected: (v) => _onSelected(v),
      getRowOper: (TreeVO<Menu> v, TreeVO<Menu> parent) => _getRowOper(v, parent),
      tableWidth: 1300,
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
    return SizedBox(width: widget.width ?? double.infinity, child: result);
  }

  _getToolbars() {
    var selected = TreeUtil.getSelected(widget.treeVOList);
    var result = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        CryButtons.add(context, () => widget.onEdit(Menu(subsystemId: widget.subsystemId))),
        CryButtons.delete(
          context,
          selected.length >= 1
              ? () {
                  cryConfirm(context, S.of(context).confirmDelete, () async {
                    List ids = selected.map((e) => e.data.id).toList();
                    ResponseBodyApi responseBodyApi = await MenuApi.removeByIds(ids);
                    Navigator.of(context).pop();
                    if (!responseBodyApi.success) {
                      return;
                    }
                    widget.reloadData();
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
        onPressed: () => widget.onEdit(Menu(pname: vo.data.name, pid: vo.data.id, subsystemId: widget.subsystemId)),
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
