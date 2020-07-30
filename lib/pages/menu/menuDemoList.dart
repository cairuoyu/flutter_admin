import 'package:flutter/material.dart';
import 'package:flutter_admin/api/menuDemoApi.dart';
import 'package:flutter_admin/models/index.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/pages/menu/menuForm.dart';
import 'package:flutter_admin/pages/menu/menuMenu.dart';
import 'package:flutter_admin/utils/adaptiveUtil.dart';
import 'package:flutter_admin/utils/treeUtil.dart';
import 'package:flutter_admin/vo/treeVO.dart';

class MenuDemoList extends StatefulWidget {
  MenuDemoList({Key key}) : super(key: key);

  @override
  _MenuDemoListState createState() => _MenuDemoListState();
}

class _MenuDemoListState extends State<MenuDemoList> {
  bool isEdit = false;
  Menu menu = Menu();
  List<TreeVO<Menu>> treeVOList;

  @override
  void initState() {
    super.initState();
    this._loadData();
  }

  @override
  Widget build(BuildContext context) {
    MenuForm menuForm = MenuForm(
      menu: menu,
      onSave: () {
        setState(() {
          this.isEdit = false;
          _loadData();
        });
      },
      onClose: () {
        this.setState(() {
          this.isEdit = false;
        });
      },
    );
    if (this.isEdit && !isDisplayDesktop(context)) {
      return menuForm;
    }
    MenuMenu menuMenu = MenuMenu(
      expand: !isEdit,
      onEdit: (v) => _onEdit(v),
      reloadData: () {
        setState(() {
          _loadData();
        });
      },
      treeVOList: treeVOList,
    );
    var result = this.isEdit && isDisplayDesktop(context)
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [menuMenu, menuForm],
          )
        : menuMenu;
    return result;
  }

  _loadData() async {
    ResponeBodyApi responeBodyApi = await MenuDemoApi.list(null);
    var data = responeBodyApi.data;
    List<Menu> list = List.from(data).map((e) => Menu.fromJson(e)).toList();
    this.treeVOList = TreeUtil.toTreeVOList(list);
    this.setState(() {});
  }

  _onEdit(Menu menu) {
    this.menu = menu;
    this.isEdit = true;
    setState(() {});
  }
}
