/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_button.dart';
import 'package:cry/cry_button_bar.dart';
import 'package:cry/utils/adaptive_util.dart';
import 'package:cry/vo/tree_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/pages/layout/layout_controller.dart';
import 'package:flutter_admin/utils/store_util.dart';
import 'package:flutter_admin/utils/tree_util.dart';
import 'package:flutter_admin/utils/utils.dart';
import 'package:get/get.dart';

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
  bool? expandMenu;
  bool expandAll = true;
  LayoutController layoutController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.expandMenu ??= isDisplayDesktop(context) || Utils.isMenuDisplayTypeDrawer(context);
    ListTile menuHeaderCollapse = ListTile(
      leading: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(Icons.chevron_left),
        onPressed: () {
          expandMenu = !expandMenu!;
          setState(() {});
        },
      ),
      trailing: SizedBox(
        width: 120,
        child: CryButtonBar(
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
        ),
      ),
    );
    ListTile menuHeaderExpand = ListTile(
      title: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(Icons.chevron_right),
        onPressed: () {
          expandMenu = !expandMenu!;
          setState(() {});
        },
      ),
    );
    var currentOpenedTabPageId = StoreUtil.readCurrentOpenedTabPageId();
    List<Widget> menuBody = _getMenuListTile(TreeUtil.toTreeVOList(StoreUtil.getMenuList()), currentOpenedTabPageId);
    ListView menu = ListView(
      key: Key('builder ${expandAll.toString()}'),
      children: Utils.isMenuDisplayTypeDrawer(context)
          ? menuBody
          : [
              expandMenu! ? menuHeaderCollapse : menuHeaderExpand,
              ...menuBody,
            ],
    );
    return Utils.isMenuDisplayTypeDrawer(context)
        ? Drawer(child: menu)
        : SizedBox(
            width: expandMenu! ? 300 : 60,
            child: menu,
          );
  }

  List<Widget> _getMenuListTile(List<TreeVO<Menu>> data, String? currentOpenedTabPageId) {
    List<Widget> listTileList = data.map<Widget>((TreeVO<Menu> treeVO) {
      IconData iconData = Utils.toIconData(treeVO.data!.icon);
      String name = Utils.isLocalEn(context) ? treeVO.data!.nameEn ?? '' : treeVO.data!.name ?? '';
      Text title = Text(expandMenu! ? name : '');
      if (treeVO.children.length > 0) {
        return ExpansionTile(
          key: Key(treeVO.data!.id!),
          initiallyExpanded: expandAll,
          leading: Icon(iconData),
          children: _getMenuListTile(treeVO.children, currentOpenedTabPageId),
          title: title,
        );
      } else {
        return ListTile(
          tileColor: currentOpenedTabPageId == treeVO.data!.id ? Colors.blue.shade100 : null,
          leading: Icon(iconData,color: context.theme.primaryColor),
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
