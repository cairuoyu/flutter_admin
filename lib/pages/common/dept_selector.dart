/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_button.dart';
import 'package:cry/cry_button_bar.dart';
import 'package:cry/form/cry_input.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:cry/utils/tree_util.dart';
import 'package:cry/vo/tree_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/dept_api.dart';
import 'package:flutter_admin/models/dept.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

class DeptSelector extends StatefulWidget {
  @override
  _DeptSelectorState createState() => _DeptSelectorState();
}

class _DeptSelectorState extends State<DeptSelector> {
  List<TreeNode> treeNodeList = <TreeNode>[];
  TreeController treeController = TreeController(allNodesExpanded: true);
  GlobalKey<FormState> queryFormKey = GlobalKey<FormState>();
  Dept dept = Dept();

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var queryForm = Form(
      key: queryFormKey,
      child: Wrap(
        children: [
          CryInput(
            label: '部门名称',
            value: dept.name,
            onSaved: (v) {
              dept.name = v;
            },
          ),
        ],
      ),
    );
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
        CryButton(
          iconData: Icons.vertical_align_center,
          label: '合并',
          onPressed: () {
            setState(() {
              treeController.collapseAll();
            });
          },
        ),
        CryButton(
          iconData: Icons.expand,
          label: '展开',
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
        title: Text('选择部门'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          queryForm,
          buttonBar,
          treeView,
        ],
      ),
    );
    return result;
  }

  reset() {
    dept = Dept();
    _loadData();
  }

  query() {
    queryFormKey.currentState!.save();
    _loadData();
  }

  _loadData() async {
    ResponseBodyApi responseBodyApi = await DeptApi.list(RequestBodyApi(params: dept.toMap()).toMap());
    var data = responseBodyApi.data;
    List<Dept> list = List.from(data).map((e) => Dept.fromMap(e)).toList();
    List<TreeVO<Dept>> treeVOList = TreeUtil.toTreeVOList(list);
    treeNodeList = toTreeNodeList(treeVOList);

    this.setState(() {});
  }

  List<TreeNode> toTreeNodeList(List<TreeVO<Dept>> treeVOList) {
    return treeVOList.map((treeVO) => toTreeNode(treeVO)).toList();
  }

  TreeNode toTreeNode(TreeVO<Dept> treeVO) {
    var key = ValueKey(treeVO.data!.id);
    var content = Expanded(
      child: ListTile(
        hoverColor: Colors.blue.shade100,
        onTap: () {
          Navigator.pop(context, treeVO.data);
        },
        title: Text(treeVO.data!.name ?? '--'),
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
