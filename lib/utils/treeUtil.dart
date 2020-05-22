import 'package:flutter_admin/vo/treeVO.dart';

class TreeUtil<T extends TreeData> {
  findChildren(List<TreeVO<T>> list, TreeVO<T> treeVO) {
    for (var v in list) {
      if (v.data.pid == treeVO.data.id) {
        treeVO.children.add(v);
      }
      if (v.children.length > 0) {
        findChildren(v.children, treeVO);
      }
    }
  }

  findParent(List<TreeVO<T>> list, TreeVO<T> treeVO) {
    for (var v in list) {
      if (v.data.id == treeVO.data.pid) {
        v.children.add(treeVO);
        return;
      }
    }
  }

  addTreeData(List<TreeVO<T>> list, T treeData) {
    TreeVO<T> treeVO = TreeVO<T>(data: treeData);
    findChildren(list, treeVO);
    findParent(list, treeVO);
    list.add(treeVO);
  }

  List<TreeVO<T>> toTreeVOList(List<T> data) {
    List<TreeVO<T>> result = [];
    data.forEach((element) {
      addTreeData(result, element);
    });
    return result.where((element) => element.data.pid == null).toList();
  }
}
