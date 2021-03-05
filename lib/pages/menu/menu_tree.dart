import 'package:cry/cry_button.dart';
import 'package:cry/cry_buttons.dart';
import 'package:cry/vo/tree_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

class MenuTree extends StatefulWidget {
  final Function onEdit;
  final Function onDelete;
  final List<TreeVO<Menu>> treeVOList;

  MenuTree({
    this.treeVOList,
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
    treeNodeList = toTreeNodeList(widget.treeVOList);
    var treeView = Expanded(
      child: SingleChildScrollView(
        child: TreeView(
          treeController: treeController,
          nodes: treeNodeList,
        ),
      ),
    );
    var buttonBar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        CryButtons.add(context, () => widget.onEdit(null)),
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

  List<TreeNode> toTreeNodeList(List<TreeVO<Menu>> treeVOList) {
    return treeVOList.map((treeVO) => toTreeNode(treeVO)).toList();
  }

  TreeNode toTreeNode(TreeVO<Menu> treeVO) {
    var trailing = SizedBox(
      width: 180,
      child: ButtonBar(
        children: [
          CryButtons.add(context, () => widget.onEdit(Menu(pid: treeVO.data.id)), showLabel: false),
          CryButtons.edit(context, () => widget.onEdit(treeVO.data), showLabel: false),
          CryButtons.delete(context, () => widget.onDelete([treeVO.data.id]), showLabel: false),
        ],
      ),
    );
    var key = ValueKey(treeVO.data.id);
    var content = Expanded(
      child: ListTile(
        leading: Icon(Utils.toIconData(treeVO.data.icon)),
        title: Text(treeVO.data.name ?? '--'),
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
      children: toTreeNodeList(treeVO.children),
    );
  }
}
