import 'package:cry/cry_button.dart';
import 'package:cry/cry_button_bar.dart';
import 'package:cry/cry_buttons.dart';
import 'package:cry/cry_dialog.dart';
import 'package:cry/form/cry_input.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:cry/vo/tree_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/dept_api.dart';
import 'package:flutter_admin/common/cry.dart';
import 'package:flutter_admin/constants/enum.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/dept.dart';
import 'package:flutter_admin/pages/dept/dept_edit.dart';
import 'package:flutter_admin/utils/tree_util.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

class DeptList extends StatefulWidget {
  @override
  _DeptListState createState() => _DeptListState();
}

class _DeptListState extends State<DeptList> {
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
            label: S.of(context).name,
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
        CryButtons.query(context, query),
        CryButtons.reset(context, reset),
        CryButtons.add(context, () => toEdit(null)),
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
    queryFormKey.currentState.save();
    _loadData();
  }

  _loadData() async {
    ResponseBodyApi responseBodyApi = await DeptApi.list(RequestBodyApi(params: dept.toMap()).toMap());
    var data = responseBodyApi.data;
    List<Dept> list = List.from(data).map((e) => Dept.fromMap(e)).toList();
    List<TreeVO<Dept>> treeVOList = TreeUtil.toTreeVOList(list);
    treeNodeList = toTreeNodeList(treeVOList);
    if (mounted) this.setState(() {});
  }

  List<TreeNode> toTreeNodeList(List<TreeVO<Dept>> treeVOList) {
    return treeVOList.map((treeVO) => toTreeNode(treeVO)).toList();
  }

  delete(List ids) async {
    await DeptApi.removeByIds(ids);
    _loadData();
  }

  toEdit(Dept dept) async {
    await Cry.push(DeptEdit(dept: dept));
    _loadData();
  }

  TreeNode toTreeNode(TreeVO<Dept> treeVO) {
    var key = ValueKey(treeVO.data.id);
    var content = Expanded(
      child: ListTile(
        title: Text(treeVO.data.name ?? '--'),
        hoverColor: Colors.blue.shade100,
        onTap: () {},
        trailing: PopupMenuButton(
          onSelected: (v) {
            if (v == OperationType.add) {
              toEdit(Dept(pid: treeVO.data.id));
            } else if (v == OperationType.edit) {
              toEdit(treeVO.data);
            } else if (v == OperationType.delete) {
              cryConfirm(context, S.of(context).confirmDelete, (context) async {
                delete([treeVO.data.id]);
                Navigator.of(context).pop();
              });
            }
          },
          itemBuilder: (context) => <PopupMenuEntry<OperationType>>[
            PopupMenuItem<OperationType>(
              value: OperationType.add,
              child: ListTile(
                leading: const Icon(Icons.add),
                title: Text('add'),
              ),
            ),
            PopupMenuItem<OperationType>(
              value: OperationType.edit,
              child: ListTile(
                leading: const Icon(Icons.edit),
                title: Text('edit'),
              ),
            ),
            PopupMenuItem<OperationType>(
              value: OperationType.delete,
              child: ListTile(
                leading: const Icon(Icons.delete),
                title: Text('delete'),
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
