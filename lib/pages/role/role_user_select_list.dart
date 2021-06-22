/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_button_bar.dart';
import 'package:cry/form/cry_input.dart';
import 'package:cry/model/order_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/role_api.dart';
import 'package:cry/cry_button.dart';
import 'package:cry/cry_data_table.dart';
import 'package:cry/model/page_model.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/role.dart';
import 'package:flutter_admin/models/user_info.dart';

class RoleUserSelectList extends StatefulWidget {
  RoleUserSelectList({
    Key? key,
    required this.role,
    this.isSelected = false,
    this.title,
  }) : super(key: key);
  final Role? role;
  final bool isSelected;
  final String? title;

  @override
  RoleUserSelectListState createState() => RoleUserSelectListState();
}

class RoleUserSelectListState extends State<RoleUserSelectList> {
  final GlobalKey<CryDataTableState> tableKey = GlobalKey<CryDataTableState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PageModel? page;
  UserInfo userInfo = UserInfo();

  @override
  void initState() {
    super.initState();
    page = PageModel(orders: [OrderItemModel(column: 'name')]);

    WidgetsBinding.instance!.addPostFrameCallback((c) {
      query();
    });
  }

  @override
  Widget build(BuildContext context) {
    var buttonBar = CryButtonBar(
      children: [
        CryButton(
          label: S.of(context).query,
          iconData: Icons.search,
          padding: EdgeInsets.only(left: 20),
          onPressed: () {
            formKey.currentState!.save();
            this.query();
          },
        ),
        CryButton(
          label: S.of(context).reset,
          iconData: Icons.refresh,
          padding: EdgeInsets.only(left: 20),
          onPressed: () {
            this.userInfo.name = null;
            this.query();
          },
        ),
      ],
    );
    var form = Form(
      key: formKey,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          CryInput(
            width: 400,
            label: S.of(context).username,
            value: userInfo.name,
            onSaved: (v) {
              userInfo.name = v;
            },
          ),
          SizedBox(child: buttonBar, width: 260),
        ],
      ),
    );

    CryDataTable table = CryDataTable(
      key: tableKey,
      title: widget.title!,
      onPageChanged: (firstRowIndex) {
        page!.current = (firstRowIndex ~/ page!.size + 1);
        query();
      },
      onRowsPerPageChanged: (int size) {
        page!.size = size;
        page!.current = 1;
        query();
      },
      onSelectChanged: (Map selected) {
        this.setState(() {});
      },
      columns: [
        DataColumn(
          label: Container(child: Text(S.of(context).username)),
          onSort: (int columnIndex, bool ascending) => _sort('userName'),
        ),
        DataColumn(
          label: Container(child: Text(S.of(context).name)),
          onSort: (int columnIndex, bool ascending) => _sort('name'),
        ),
      ],
      getCells: (m) {
        UserInfo userInfo = UserInfo.fromMap(m);
        return [
          DataCell(Container(width: 100, child: Text(userInfo.userName ?? '--'))),
          DataCell(Container(width: 100, child: Text(userInfo.name ?? '--'))),
        ];
      },
    );
    var result = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          form,
          Row(children: [
            Expanded(
              child: table,
            )
          ]),
        ],
      ),
    );
    return result;
  }

  List<UserInfo> getSelectedList() {
    List<UserInfo> selectedList = tableKey.currentState?.getSelectedList(page!).map<UserInfo>((e) => UserInfo.fromMap(e)).toList() ?? [];
    return selectedList;
  }

  query() async {
    Map params = {'roleId': widget.role!.id, 'userName': this.userInfo.name};
    RequestBodyApi requestBodyApi = RequestBodyApi();
    requestBodyApi.page = page;
    requestBodyApi.params = params;
    ResponseBodyApi responseBodyApi;
    if (widget.isSelected) {
      responseBodyApi = await RoleApi.getSelectedUserInfo(requestBodyApi.toMap());
    } else {
      responseBodyApi = await RoleApi.getUnSelectedUserInfo(requestBodyApi.toMap());
    }
    page = PageModel.fromMap(responseBodyApi.data);

    tableKey.currentState!.loadData(page!);
  }

  _sort(column, {ascending}) {
    page!.orders[0].column = column;
    page!.orders[0].asc = ascending ?? !page!.orders[0].asc!;
    query();
  }
}
