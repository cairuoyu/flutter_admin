/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_button.dart';
import 'package:cry/cry_dialog.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/utils/adaptive_util.dart';
import 'package:cry/utils/cry_utils.dart';
import 'package:cry/utils/tree_util.dart';
import 'package:cry/vo/tree_vo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/menu_api.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/models/subsystem.dart';
import 'package:flutter_admin/pages/menu/menu_edit.dart';
import 'package:flutter_admin/pages/menu/menu_table_tree.dart';
import 'package:flutter_admin/pages/menu/menu_tree.dart';

class MenuList extends StatefulWidget {
  final Subsystem? subsystem;

  MenuList({Key? key, this.subsystem}) : super(key: key);

  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  bool isEdit = false;
  bool showTree = true;
  Menu menu = Menu();
  List<TreeVO<Menu>>? treeVOList;

  @override
  void initState() {
    super.initState();
    this._loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (treeVOList == null) {
      return Container();
    }
    MenuEdit menuEdit = MenuEdit(
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
      return menuEdit;
    }
    MenuTableTree menuTableTree = MenuTableTree(
      treeVOList: treeVOList!,
      onDelete: (v) => _onDelete(v),
      onEdit: (v) => _onEdit(v),
    );
    MenuTree menuTree = MenuTree(
      treeVOList: treeVOList!,
      onDelete: (v) => _onDelete(v),
      onEdit: (v) => _onEdit(v),
    );
    var right = showTree ? menuTree : menuTableTree;
    var body = this.isEdit && isDisplayDesktop(context)
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [isEdit ? SizedBox(width: 400.0, child: right) : right, menuEdit],
          )
        : right;
    var result = Scaffold(
      appBar: AppBar(
        title: Text(widget.subsystem!.name ?? '' + ' -- ' + S.of(context).menuManagement),
        actions: [
          CryButton(
            label: showTree ? '表格树' : '树',
            iconData: showTree ? Icons.table_view : Icons.account_tree,
            onPressed: () {
              setState(() {
                showTree = !showTree;
              });
            },
          )
        ],
      ),
      body: body,
    );
    return result;
  }

  _loadData() async {
    ResponseBodyApi responseBodyApi = await MenuApi.list(RequestBodyApi(params: Menu(subsystemId: widget.subsystem!.id).toMap()).toMap());
    var data = responseBodyApi.data;
    List<Menu> list = List.from(data).map((e) => Menu.fromMap(e)).toList();
    this.treeVOList = TreeUtil.toTreeVOList(list);
    if (mounted) this.setState(() {});
  }

  _onEdit(Menu menu) {
    menu.subsystemId = widget.subsystem!.id;
    this.menu = menu;
    this.isEdit = true;
    setState(() {});
  }

  _onDelete(List<String> ids) {
    cryConfirm(context, S.of(context).confirmDelete, (context) async {
      ResponseBodyApi responseBodyApi = await MenuApi.removeByIds(ids);
      if (!responseBodyApi.success!) {
        return;
      }
      CryUtils.message(S.of(context).success);
      _loadData();
    });
  }
}
