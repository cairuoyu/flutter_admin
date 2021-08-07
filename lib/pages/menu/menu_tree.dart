/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_button.dart';
import 'package:cry/cry_button_bar.dart';
import 'package:cry/cry_buttons.dart';
import 'package:cry/vo/tree_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

class MenuTree extends StatefulWidget {
  final Function(Menu)? onEdit;
  final Function(List<String>)? onDelete;
  final List<TreeVO<Menu>> treeVOList;

  MenuTree({
    required this.treeVOList,
    this.onEdit,
    this.onDelete,
  });

  @override
  _MenuTreeState createState() => _MenuTreeState();
}

class _MenuTreeState extends State<MenuTree> {
  List<TreeNode> treeNodeList = <TreeNode>[];
  TreeController treeController = TreeController(allNodesExpanded: true);
  Menu menu = Menu();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    treeNodeList = toTreeNodeList(widget.treeVOList, null);
    var treeView = Expanded(
      child: SingleChildScrollView(
        child: TreeView(
          treeController: treeController,
          nodes: treeNodeList,
        ),
      ),
    );
    var buttonBar = CryButtonBar(
      children: [
        if (widget.onEdit != null) CryButtons.add(context, () => widget.onEdit!(Menu())),
        CryButton(
          iconData: Icons.vertical_align_center,
          label: S.of(context).collapse,
          onPressed: () {
            setState(() {
              treeController.collapseAll();
            });
          },
        ),
        CryButton(
          iconData: Icons.expand,
          label: S.of(context).expand,
          onPressed: () {
            setState(() {
              treeController.expandAll();
            });
          },
        ),
      ],
    );
    var result = Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buttonBar,
          treeView,
        ],
      ),
    );
    return result;
  }

  List<TreeNode> toTreeNodeList(List<TreeVO<Menu>> treeVOList, TreeVO<Menu>? parent) {
    return treeVOList.map((treeVO) => toTreeNode(treeVO, parent)).toList();
  }

  TreeNode toTreeNode(TreeVO<Menu> treeVO, TreeVO<Menu>? parent) {
    Menu menu = treeVO.data!;
    var trailing = SizedBox(
      width: 180,
      child: CryButtonBar(
        children: [
          CryButtons.add(
            context,
            () => widget.onEdit!(Menu(pname: menu.name, pid: menu.id)),
            showLabel: false,
          ),
          CryButtons.edit(context, () {
            if (parent != null) {
              menu.pname = parent.data!.name;
            }
            widget.onEdit!(menu);
          }, showLabel: false),
          if (widget.onDelete != null)
            CryButtons.delete(
              context,
              () => widget.onDelete!([menu.id!]),
              showLabel: false,
            ),
        ],
      ),
    );
    var key = ValueKey(treeVO.data!.id);
    var content = Expanded(
      child: ListTile(
        leading: Icon(Utils.toIconData(treeVO.data!.icon)),
        title: Text(treeVO.data!.name ?? '--'),
        hoverColor: Colors.blue.shade100,
        onTap: () {},
        trailing: trailing,
      ),
    );

    if (treeVO.children.isEmpty) {
      return TreeNode(
        key: key,
        content: content,
      );
    }

    return TreeNode(
      key: key,
      content: content,
      children: toTreeNodeList(treeVO.children, treeVO),
    );
  }
}
