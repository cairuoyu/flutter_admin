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
  final GlobalKey<CryDataTableState> tableKey = GlobalKey<CryDataTableState>();
  model.Page page;

  @override
  void initState() {
    super.initState();
    page = model.Page(orders: [model.OrderItem(column: 'name')]);

    WidgetsBinding.instance.addPostFrameCallback((c) {
      _query();
    });
  }

  @override
  Widget build(BuildContext context) {
    CryDataTable table = CryDataTable(
      key: tableKey,
      title: '角色管理',
      page: page,
      onPageChanged: _onPageChanged,
      onSelectChanged: (Map selected) {
        this.setState(() {});
      },
      columns: [
        DataColumn(
          label: Container(
            alignment: Alignment.center,
            child: Text('操作'),
            width: 240,
          ),
        ),
        DataColumn(
          label: Container(
            child: Text('名称'),
            width: 800,
          ),
          onSort: (int columnIndex, bool ascending) => _sort('name', ascending),
        ),
      ],
      getCells: (Map m) {
        Role role = Role.fromJson(m);
        return [
          DataCell(
            Container(
              width: 240,
              child: ButtonBar(
                children: [
                  CryButton(iconData: Icons.edit, tip: '编辑', onPressed: () => _edit(role)),
                  CryButton(iconData: Icons.delete, tip: '删除', onPressed: () => _delete([role])),
                  CryButton(iconData: Icons.menu, tip: '授权菜单', onPressed: () {}),
                  CryButton(iconData: Icons.person, tip: '关联人员', onPressed: () {}),
                ],
              ),
            ),
          ),
          DataCell(Container(width: 800, child: Text(role.name ?? '--'))),
        ];
      },
    );
    List<Role> selectedList =
        tableKey?.currentState?.getSelectedList(page)?.map<Role>((e) => Role.fromJson(e))?.toList() ?? [];
    ButtonBar buttonBar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        CryButton(
          label: '查询',
          onPressed: () {
            _query();
          },
        ),
        CryButton(
          label: '增加',
          onPressed: () {
            _add();
          },
        ),
        CryButton(
          label: '删除',
          onPressed: selectedList.length == 0
              ? null
              : () {
                  _delete(selectedList);
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

  _add() {
    cryDialog(
      context: context,
      title: S.of(context).increase,
      body: RoleEdit(),
    ).then((v) {
      if (v != null) {
        _query();
      }
    });
  }

  _edit(Role role) {
    cryDialog(
      context: context,
      title: role == null ? S.of(context).increase : S.of(context).modify,
      body: RoleEdit(
        role: role,
      ),
    ).then((v) {
      if (v != null) {
        _query();
      }
    });
  }

  _delete(List<Role> roleList) {
    if (roleList == null || roleList.length == 0) {
      return;
    }
    cryConfirm(context, S.of(context).confirmDelete, () async {
      await RoleApi.removeByIds(roleList.map((e) => e.id).toList());
      _query();
      Navigator.of(context).pop();
    });
  }

  _query() async {
    model.RequestBodyApi requestBodyApi = model.RequestBodyApi();
    requestBodyApi.page = page;
    ResponeBodyApi responeBodyApi = await RoleApi.page(requestBodyApi);
    page = model.Page.fromJson(responeBodyApi.data);

    setState(() {});
  }

  _sort(column, ascending) {
    page.orders[0].column = column;
    page.orders[0].asc = !page.orders[0].asc;
    _query();
  }

  _onPageChanged(int current) {
    page.current = current;
    _query();
  }
}
