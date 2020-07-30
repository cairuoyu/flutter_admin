import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../api/menuApi.dart';
import '../../models/menu.dart';
import '../../models/responeBodyApi.dart';
import '../../utils/adaptiveUtil.dart';
import '../../utils/treeUtil.dart';
import '../../utils/utils.dart';
import '../../vo/treeVO.dart';

class LayoutMenu extends StatefulWidget {
  LayoutMenu({Key key, this.onClick}) : super(key: key);
  final Function onClick;

  @override
  _LayoutMenuState createState() => _LayoutMenuState();
}

class _LayoutMenuState extends State<LayoutMenu> {
  List<TreeVO<Menu>> treeVOList = [];
  bool expandMenu = true;

  @override
  void initState() {
    super.initState();
    this._loadData();
    this.expandMenu = isDisplayDesktopInit();
  }

  @override
  Widget build(BuildContext context) {
    ListTile menuHeader = ListTile(
      title: Icon(Icons.menu),
      onTap: () {
        expandMenu = !expandMenu;
        setState(() {});
      },
    );
    List<Widget> menuBody = _getMenuListTile(treeVOList);
    ListView menu = ListView(children: [menuHeader, ...menuBody]);
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

  _loadData() async {
    ResponeBodyApi responeBodyApi = await MenuApi.list(null);
    var data = responeBodyApi.data;
    List<Menu> list = List.from(data).map((e) => Menu.fromJson(e)).toList();
    this.treeVOList = TreeUtil.toTreeVOList(list);
    this.setState(() {
      if (treeVOList.length > 0) {
        if (widget.onClick != null) widget.onClick(treeVOList[0]);
      }
    });
  }

  List<Widget> _getMenuListTile(List<TreeVO<Menu>> data) {
    List<Widget> listTileList = data.map<Widget>((TreeVO<Menu> treeVO) {
      IconData iconData = Utils.toIconData(treeVO.data.icon);
      String name = Intl.defaultLocale == 'en' ? treeVO.data.nameEn ?? '' : treeVO.data.name ?? '';
      Text title = Text(expandMenu ? name : '');
      if (treeVO.children != null && treeVO.children.length > 0) {
        return ExpansionTile(
          leading: Icon(expandMenu ? treeVO.icon : null),
          backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
          children: _getMenuListTile(treeVO.children),
          title: title,
        );
      } else {
        return ListTile(
          leading: Icon(iconData),
          title: title,
          onTap: () {
            if (widget.onClick != null) widget.onClick(treeVO);
          },
        );
      }
    }).toList();
    return listTileList;
  }
}
