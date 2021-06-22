/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description: 树工具类

import 'package:cry/vo/tree_vo.dart';

class TreeUtil {
  static findChildren<T extends TreeData>(List<TreeVO<T>> list, TreeVO<T> treeVO) {
    for (TreeVO<T> v in list) {
      if (v.data!.pid == treeVO.data!.id) {
        treeVO.children.add(v);
        v.parent = treeVO;
      }
    }
  }

  static bool findParent<T extends TreeData>(List<TreeVO<T>> list, TreeVO<T> treeVO) {
    for (TreeVO<T> v in list) {
      if (v.data!.id == treeVO.data!.pid) {
        v.children.add(treeVO);
        treeVO.parent = v;
        return true;
      }
      if (v.children.length > 0) {
        if (findParent(v.children, treeVO)) {
          return true;
        }
      }
    }
    return false;
  }

  static addTreeData<T extends TreeData>(List<TreeVO<T>> list, T treeData) {
    TreeVO<T> treeVO = TreeVO<T>(data: treeData);
    if (treeData.checked != null) {
      treeVO.checked = treeData.checked;
    }
    findChildren(list, treeVO);
    findParent(list, treeVO);
    list.add(treeVO);
  }

  static List<TreeVO<T>> toTreeVOList<T extends TreeData>(List<T> data) {
    List<TreeVO<T>> result = [];
    data.forEach((element) {
      addTreeData(result, element);
    });
    return result.where((element) => element.data!.pid == null).toList();
  }

  static List<TreeVO<T>> getSelected<T extends TreeData>(List<TreeVO<T>>? data) {
    if (data == null) {
      return [];
    }
    var selected = <TreeVO<T>>[];
    data.forEach((element) {
      if (element.checked!) {
        selected.add(element);
      }
      if (element.children.length > 0) {
        selected.addAll(getSelected(element.children));
      }
    });
    return selected;
  }
}
