import 'package:cry/vo/tree_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/utils/store_util.dart';
import 'package:flutter_admin/utils/tree_util.dart';

import '../../models/menu.dart';
import '../../utils/adaptive_util.dart';
import '../../utils/utils.dart';

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
    List<Widget> menuBody = _getMenuListTile(TreeUtil.toTreeVOList(StoreUtil.instance.menuTree));
    ListView menu = ListView(children: Utils.isMenuDisplayTypeDrawer(context) ? menuBody : [menuHeader, ...menuBody]);
    return SizedBox(
      width: expandMenu ? 300 : 60,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[50],
          // border: Border(right: BorderSide(color: Colors.black)),
        ),
        child: menu,
      ),
    );
  }

  bool isCurrentOpenedMenu(List<TreeVO<Menu>> data) {
    for (var treeVO in data) {
      if (treeVO.children != null && treeVO.children.length > 0) {
        return isCurrentOpenedMenu(treeVO.children);
      }
      return StoreUtil.instance.currentOpenedMenuId == treeVO.data.id;
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
          leading: Icon(expandMenu ? treeVO.icon : null),
          backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
          children: _getMenuListTile(treeVO.children),
          title: title,
        );
      } else {
        return ListTile(
          tileColor: StoreUtil.instance.currentOpenedMenuId == treeVO.data.id ? Colors.blue.shade100 : Colors.white,
          leading: Icon(iconData),
          title: title,
          onTap: () {
            if (widget.onClick != null) widget.onClick(treeVO.data);
          },
        );
      }
    }).toList();
    return listTileList;
  }
}
