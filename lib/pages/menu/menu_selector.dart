/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/7/6
/// @version: 1.0
/// @description:

import 'package:cry/cry_button.dart';
import 'package:cry/cry_button_bar.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:cry/utils/tree_util.dart';
import 'package:cry/vo/tree_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/menu_api.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

class MenuSelector extends StatefulWidget {
  final String subsystemId;

  MenuSelector({
    required this.subsystemId,
  });

  @override
  _MenuSelectorState createState() => _MenuSelectorState();
}

class _MenuSelectorState extends State<MenuSelector> {
  List<TreeNode> treeNodeList = <TreeNode>[];
  TreeController treeController = TreeController(allNodesExpanded: true);
  Menu menu = Menu();

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    ResponseBodyApi responseBodyApi = await MenuApi.list(RequestBodyApi(params: Menu(subsystemId: widget.subsystemId).toMap()).toMap());
    var data = responseBodyApi.data;
    List<Menu> list = List.from(data).map((e) => Menu.fromMap(e)).toList();
    treeNodeList = toTreeNodeList(TreeUtil.toTreeVOList(list), null);
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var buttonBar = CryButtonBar(
      children: [
        CryButton(
          iconData: Icons.menu,
          label: '根节点',
          onPressed: () {
            Navigator.pop(context, Menu(name: '根节点'));
          },
        ),
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
      appBar: AppBar(
        title: Text('选择父菜单'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buttonBar,
          if (treeNodeList.isNotEmpty)
            Expanded(
              child: SingleChildScrollView(
                child: TreeView(
                  treeController: treeController,
                  nodes: treeNodeList,
                ),
              ),
            )
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
    var key = ValueKey(menu.id);
    var content = Expanded(
      child: ListTile(
        leading: Icon(Utils.toIconData(menu.icon)),
        title: Text(menu.name ?? '--'),
        hoverColor: Colors.blue.shade100,
        onTap: () {
          Navigator.pop(context, menu);
        },
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
