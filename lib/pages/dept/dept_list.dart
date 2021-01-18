import 'package:cry/cry_buttons.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:cry/vo/tree_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/dept_api.dart';
import 'package:flutter_admin/models/dept.dart';
import 'package:flutter_admin/utils/tree_util.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

class DeptList extends StatefulWidget {
  @override
  _DeptListState createState() => _DeptListState();
}

class _DeptListState extends State<DeptList> {
  List<TreeNode> treeNodeList = <TreeNode>[];
  TreeController treeController = TreeController(allNodesExpanded: true);

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var treeView = TreeView(
      treeController: treeController,
      nodes: treeNodeList,
    );
    var result = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CryButtons.add(context, () {
          setState(() {});
        }),
        treeView,
      ],
    );
    return result;
  }

  _loadData() async {
    ResponseBodyApi responseBodyApi = await DeptApi.list(RequestBodyApi(params: Dept().toMap()).toMap());
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
    var key = ValueKey(treeVO.data.id);
    var content = Expanded(
      child: ListTile(
        title: Text(treeVO.data.name ?? '--'),
        trailing: PopupMenuButton(
          onSelected: (v) {},
          itemBuilder: (context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'add',
              child: ListTile(
                leading: const Icon(Icons.add),
                title: Text('add'),
              ),
            ),
            PopupMenuItem<String>(
              value: 'edit',
              child: ListTile(
                leading: const Icon(Icons.edit),
                title: Text('edit'),
              ),
            ),
          ],
        ),
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
