/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_button_bar.dart';
import 'package:cry/cry_data_table.dart';
import 'package:cry/cry_dialog.dart';
import 'package:cry/model/order_item_model.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/utils/cry_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/role_api.dart';
import 'package:cry/cry_button.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:cry/model/page_model.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/models/role.dart';
import 'package:flutter_admin/pages/role/role_edit.dart';
import 'package:flutter_admin/pages/role/role_subsystem_list.dart';
import 'package:flutter_admin/pages/role/role_user_select.dart';
import 'package:flutter_admin/utils/utils.dart';

class RoleList extends StatefulWidget {
  RoleList({Key? key}) : super(key: key);

  @override
  _RoleListState createState() => _RoleListState();
}

class _RoleListState extends State<RoleList> {
  final GlobalKey<CryDataTableState> tableKey = GlobalKey<CryDataTableState>();
  PageModel page = PageModel(orders: [OrderItemModel(column: 'name')]);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((c) {
      _query();
    });
  }

  @override
  Widget build(BuildContext context) {
    CryDataTable table = CryDataTable(
      key: tableKey,
      onPageChanged: (firstRowIndex) {
        page.current = (firstRowIndex ~/ page.size + 1);
        _query();
      },
      onRowsPerPageChanged: (int size) {
        page.size = size;
        page.current = 1;
        _query();
      },
      onSelectChanged: (Map selected) {
        this.setState(() {});
      },
      columns: [
        DataColumn(
          label: Container(
            alignment: Alignment.center,
            child: Text(S.of(context).operating),
            width: 240,
          ),
        ),
        DataColumn(
          label: Container(
            child: Text(S.of(context).name),
            width: 800,
          ),
          onSort: (int columnIndex, bool ascending) => _sort('name', ascending),
        ),
      ],
      getCells: (m) {
        Role role = Role.fromMap(m);
        return [
          DataCell(
            CryButtonBar(
              children: [
                CryButton(iconData: Icons.edit, tip: S.of(context).modify, onPressed: () => _edit(role)),
                CryButton(iconData: Icons.delete, tip: S.of(context).delete, onPressed: () => _delete([role])),
                CryButton(iconData: Icons.person, tip: S.of(context).selectUsers, onPressed: () => _selectUser(role)),
                CryButton(iconData: Icons.menu, tip: S.of(context).selectMenus, onPressed: () => _selectMenu(role)),
              ],
            ),
          ),
          DataCell(Text(role.name ?? '--')),
        ];
      },
    );
    List<Role> selectedList = tableKey.currentState?.getSelectedList(page).map<Role>((e) => Role.fromMap(e)).toList() ?? [];
    var buttonBar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        CryButton(
          label: S.of(context).query,
          iconData: Icons.search,
          onPressed: () {
            _query();
          },
        ),
        CryButton(
          label: S.of(context).add,
          iconData: Icons.add,
          onPressed: () {
            _edit(null);
          },
        ),
        CryButton(
          label: S.of(context).delete,
          iconData: Icons.delete,
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
          buttonBar,
          Expanded(child: SingleChildScrollView(child: table)),
        ],
      ),
    );
    return result;
  }

  _selectMenu(Role role) {
    Utils.fullscreenDialog(RoleSubsystemList(role: role));
  }

  _selectUser(Role role) {
    Utils.fullscreenDialog(RoleUserSelect(role: role));
  }

  _edit(Role? role) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: RoleEdit(
          role: role,
        ),
      ),
    ).then((v) {
      if (v != null) {
        _query();
      }
    });
  }

  _delete(List<Role> roleList) {
    if (roleList.length == 0) {
      return;
    }
    cryConfirm(context, S.of(context).confirmDelete, (context) async {
      var result = await RoleApi.removeByIds(roleList.map((e) => e.id).toList());
      if (result.success) {
        _query();
        CryUtils.message(S.of(context).success);
      }
    });
  }

  _query() async {
    RequestBodyApi requestBodyApi = RequestBodyApi();
    requestBodyApi.page = page;
    ResponseBodyApi responseBodyApi = await RoleApi.page(requestBodyApi.toMap());
    page = responseBodyApi.data != null ? PageModel.fromMap(responseBodyApi.data) : PageModel();
    setState(() {
      tableKey.currentState!.loadData(page);
    });
  }

  _sort(column, ascending) {
    page.orders[0].column = column;
    page.orders[0].asc = !page.orders[0].asc!;
    _query();
  }
}
