import 'package:flutter/material.dart';
import 'package:flutter_admin/api/roleApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/cryDataTable.dart';
import 'package:flutter_admin/components/cryDialog.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/index.dart' as model;
import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:flutter_admin/models/role.dart';
import 'package:flutter_admin/pages/role/roleEdit.dart';

class RoleList extends StatefulWidget {
  RoleList({Key key}) : super(key: key);

  @override
  _RoleListState createState() => _RoleListState();
}

class _RoleListState extends State<RoleList> {
  model.Page page = model.Page();
  List<Role> dataList = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((c) {
      _query();
    });
  }

  @override
  Widget build(BuildContext context) {
    CryDataTable table = CryDataTable<Role>(
      title: '角色管理',
      page: page,
      dataList: dataList,
      columns: [
        DataColumn(label: Text('name')),
        DataColumn(label: Text('操作')),
      ],
      getCells: (Role p) => [
        DataCell(Text(p.name)),
        DataCell(ButtonBar(
          children: [
            CryButton(iconData: Icons.edit, tip: '编辑', onPressed: () => _edit(p)),
            CryButton(iconData: Icons.delete, tip: '删除', onPressed: () {}),
            CryButton(iconData: Icons.menu, tip: '授权菜单', onPressed: () {}),
            CryButton(iconData: Icons.person, tip: '关联人员', onPressed: () {}),
          ],
        )),
      ],
    );

    ButtonBar buttonBar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        CryButton(
          label: '查询',
          onPressed: () {
            _query();
          },
        ),
      ],
    );
    var result = Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          // form,
          buttonBar,
          Expanded(
            child: table,
          ),
        ],
      ),
    );
    return result;
  }

  _edit(Role role) {
    cryDialog(
      context: context,
      title: role == null ? S.of(context).increase : S.of(context).modify,
      body: RoleEdit(),
    ).then((v) {
      if (v != null) {
        _query();
      }
    });
  }

  _query() async {
    model.RequestBodyApi requestBodyApi = model.RequestBodyApi();
    requestBodyApi.page = page;
    ResponeBodyApi responeBodyApi = await RoleApi.page(requestBodyApi);
    page = model.Page.fromJson(responeBodyApi.data);

    dataList = page.records.map<Role>((v) {
      Role role = Role.fromJson(v);
      role.selected = false;
      return role;
    }).toList();
    setState(() {});
  }
}
