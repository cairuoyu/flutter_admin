import 'package:cry/utils/adaptive_util.dart';
import 'package:cry/vo/tree_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/pages/layout/layout_controller.dart';
import 'package:flutter_admin/utils/tree_util.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get/get.dart';

class LayoutMenu extends StatefulWidget {
  LayoutMenu({
    Key key,
    this.onClick,
  }) : super(key: key);
  final Function onClick;

  @override
  _LayoutMenuState createState() => _LayoutMenuState();
}

class _LayoutMenuState extends State<LayoutMenu> {
  bool expandMenu;
  LayoutController layoutController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.expandMenu ??= isDisplayDesktop(context) || Utils.isMenuDisplayTypeDrawer(context);
    ListTile menuHeader = ListTile(
      title: Icon(Icons.menu),
      onTap: () {
        expandMenu = !expandMenu;
        setState(() {});
      },
    );

    List<Widget> menuBody = _getMenuListTile(TreeUtil.toTreeVOList(Utils.getMenuTree()));
    ListView menu = ListView(
      children: Utils.isMenuDisplayTypeDrawer(context) ? menuBody : [menuHeader, ...menuBody],
    );
    return Utils.isMenuDisplayTypeDrawer(context)
        ? Drawer(child: menu)
        : SizedBox(
            width: expandMenu ? 300 : 60,
            child: menu,
          );
  }

  bool isCurrentOpenedMenu(List<TreeVO<Menu>> data) {
    for (var treeVO in data) {
      if (treeVO.children != null && treeVO.children.length > 0) {
        return isCurrentOpenedMenu(treeVO.children);
      }
      return layoutController.currentOpenedTabPageId == treeVO.data.id;
    }
    return false;
  }

  List<Widget> _getMenuListTile(List<TreeVO<Menu>> data) {
    if (data == null) {
      return [];
    }
    List<Widget> listTileList = data.map<Widget>((TreeVO<Menu> treeVO) {
      IconData iconData = Utils.toIconData(treeVO.data.icon);
      String name = Utils.isLocalEn(context) ? treeVO.data.nameEn ?? '' : treeVO.data.name ?? '';
      Text title = Text(expandMenu ? name : '');
      if (treeVO.children != null && treeVO.children.length > 0) {
        return ExpansionTile(
          initiallyExpanded: isCurrentOpenedMenu(treeVO.children),
          leading: Icon(iconData),
          children: _getMenuListTile(treeVO.children),
          title: title,
        );
      } else {
        return ListTile(
          tileColor: layoutController.currentOpenedTabPageId == treeVO.data.id ? Colors.blue.shade100 : null,
          leading: Icon(iconData),
          title: title,
          onTap: () {
            if (layoutController.currentOpenedTabPageId != treeVO.data.id && widget.onClick != null) {
              widget.onClick(treeVO.data.toTabPage());
              setState(() {});
            }
          },
        );
      }
    }).toList();
    return listTileList;
  }
}
