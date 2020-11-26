import 'package:cry/vo/tree_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/menu_demo_api.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/pages/menu/menu_form.dart';
import 'package:flutter_admin/pages/menu/menu_menu.dart';
import 'package:flutter_admin/utils/adaptive_util.dart';
import 'package:flutter_admin/utils/tree_util.dart';

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
      width: isEdit ? 400.0 : null,
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
    ResponseBodyApi responseBodyApi = await MenuDemoApi.list(null);
    var data = responseBodyApi.data;
    List<Menu> list = List.from(data).map((e) => Menu.fromMap(e)).toList();
    this.treeVOList = TreeUtil.toTreeVOList(list);
    this.setState(() {});
  }

  _onEdit(Menu menu) {
    this.menu = menu;
    this.isEdit = true;
    setState(() {});
  }
}
