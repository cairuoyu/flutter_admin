/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_button.dart';
import 'package:cry/utils/tree_util.dart';
import 'package:cry/vo/tree_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/utils/store_util.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get/get.dart';

import 'layout_menu_controller.dart';

class LayoutMenu extends StatefulWidget {
  LayoutMenu({
    Key? key,
    this.onClick,
  }) : super(key: key);
  final Function? onClick;

  @override
  _LayoutMenuState createState() => _LayoutMenuState();
}

class _LayoutMenuState extends State<LayoutMenu> {
  final double headerHeight = 48;
  bool expandMenu = true;
  bool expandAll = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GetBuilder<LayoutMenuController>(builder: (_) => _build(context));

  Widget _build(BuildContext context) {
    var menuHeaderExpand = Row(
      children: [
        if (!Utils.isMenuDisplayTypeDrawer(context))
          CryButton(
            iconData: Icons.chevron_left,
            onPressed: () {
              expandMenu = !expandMenu;
              setState(() {});
            },
          ),
        Expanded(
          child: Row(
            children: [
              CryButton(
                iconData: Icons.expand,
                onPressed: () {
                  setState(() {
                    expandAll = true;
                  });
                },
              ),
              CryButton(
                iconData: Icons.vertical_align_center,
                onPressed: () {
                  setState(() {
                    expandAll = false;
                  });
                },
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
        ),
      ],
    );

    var menuHeaderCollapse = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CryButton(
          iconData: Icons.chevron_right,
          onPressed: () {
            expandMenu = !expandMenu;
            setState(() {});
          },
        ),
      ],
    );
    var menuHeader = Material(
      type: MaterialType.transparency,
      child: Container(
        height: headerHeight,
        child: expandMenu ? menuHeaderExpand : menuHeaderCollapse,
      ),
    );
    var menuBody = ListView(
      key: Key('builder ${expandAll.toString()}'),
      children: [
        SizedBox(height: headerHeight),
        ..._getMenuListTile(TreeUtil.toTreeVOList(StoreUtil.getMenuList()), StoreUtil.readCurrentOpenedTabPageId()),
      ],
    );
    var menuStack = Stack(
      alignment: Alignment.topCenter,
      children: [
        menuBody,
        menuHeader,
        Divider(
          thickness: 1,
          color: Colors.black26,
          height: headerHeight * 2 - 1,
        ),
      ],
    );
    var result = Utils.isMenuDisplayTypeDrawer(context)
        ? Drawer(child: menuStack)
        : SizedBox(
            width: expandMenu ? 350 : 60,
            child: menuStack,
          );
    return result;
  }

  List<Widget> _getMenuListTile(List<TreeVO<Menu>> data, String? currentOpenedTabPageId) {
    List<Widget> listTileList = data.map<Widget>((TreeVO<Menu> treeVO) {
      IconData iconData = Utils.toIconData(treeVO.data!.icon);
      String name = Utils.isLocalEn(context) ? treeVO.data!.nameEn ?? '' : treeVO.data!.name ?? '';
      Text title = Text(expandMenu ? name : '');
      if (treeVO.children.length > 0) {
        bool hasChildrenOpened = treeVO.children.any((element) => currentOpenedTabPageId == element.data!.id);
        return ExpansionTile(
          key: Key(treeVO.data!.id!),
          initiallyExpanded: hasChildrenOpened || expandAll,
          leading: Icon(iconData),
          children: _getMenuListTile(treeVO.children, currentOpenedTabPageId),
          title: title,
          childrenPadding: EdgeInsets.only(left: this.expandMenu ? 30 : 0),
        );
      } else {
        return ListTile(
          tileColor: currentOpenedTabPageId == treeVO.data!.id ? Colors.blue.shade100 : null,
          leading: Icon(iconData, color: context.theme.primaryColor),
          title: title,
          onTap: () {
            if (currentOpenedTabPageId != treeVO.data!.id && widget.onClick != null) {
              widget.onClick!(treeVO.data);
            }
          },
        );
      }
    }).toList();
    return listTileList;
  }
}
