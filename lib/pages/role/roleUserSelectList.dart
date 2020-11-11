import 'package:flutter/material.dart';
import 'package:flutter_admin/api/roleApi.dart';
import 'package:cry/cry_button.dart';
import 'package:flutter_admin/components/cryDataTable.dart';
import 'package:flutter_admin/components/form2/cryInput.dart';
import 'package:flutter_admin/models/orderItem.dart';
import 'package:flutter_admin/models/page.dart';
import 'package:flutter_admin/models/requestBodyApi.dart';
import 'package:flutter_admin/models/responseBodyApi.dart';
import 'package:flutter_admin/models/role.dart';
import 'package:flutter_admin/models/userInfo.dart';

class RoleUserSelectList extends StatefulWidget {
  RoleUserSelectList({
    Key key,
    @required this.role,
    this.isSelected = false,
    this.title,
  }) : super(key: key);
  final Role role;
  final bool isSelected;
  final String title;

  @override
  RoleUserSelectListState createState() => RoleUserSelectListState();
}

class RoleUserSelectListState extends State<RoleUserSelectList> {
  final GlobalKey<CryDataTableState> tableKey = GlobalKey<CryDataTableState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PageModel page;
  UserInfo userInfo = UserInfo();

  @override
  void initState() {
    super.initState();
    page = PageModel(orders: [OrderItem(column: 'name')]);

    WidgetsBinding.instance.addPostFrameCallback((c) {
      query();
    });
  }

  @override
  Widget build(BuildContext context) {
    var buttonBar = ButtonBar(
      children: [
        CryButton(
          label: '查询',
          iconData: Icons.search,
          padding: EdgeInsets.only(left: 20),
          onPressed: () {
            formKey.currentState.save();
            this.query();
          },
        ),
        CryButton(
          label: '重置',
          iconData: Icons.refresh,
          padding: EdgeInsets.only(left: 20),
          onPressed: () {
            this.userInfo.name = null;
            this.query();
          },
        ),
      ],
      alignment: MainAxisAlignment.start,
    );
    var form = Form(
      key: formKey,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          CryInput(
            width: 400,
            label: '用户名称',
            value: userInfo.name,
            onSaved: (v) {
              userInfo.name = v;
            },
          ),
          SizedBox(child: buttonBar, width: 250),
        ],
      ),
    );

    CryDataTable table = CryDataTable(
      key: tableKey,
      title: widget.title,
      page: page,
      onPageChanged: _onPageChanged,
      onSelectChanged: (Map selected) {
        this.setState(() {});
      },
      columns: [
        DataColumn(
          label: Container(child: Text('名称')),
          onSort: (int columnIndex, bool ascending) => _sort('name'),
        ),
      ],
      getCells: (Map m) {
        UserInfo userInfo = UserInfo.fromMap(m);
        return [
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
    List<UserInfo> selectedList =
        tableKey?.currentState?.getSelectedList(page)?.map<UserInfo>((e) => UserInfo.fromMap(e))?.toList() ?? [];
    return selectedList;
  }

  query() async {
    Map params = {'roleId': widget.role.id, 'userName': this.userInfo.name};
    RequestBodyApi requestBodyApi = RequestBodyApi();
    requestBodyApi.page = page;
    requestBodyApi.params = params;
    ResponseBodyApi responseBodyApi;
    if (widget.isSelected) {
      responseBodyApi = await RoleApi.getSelectedUserInfo(requestBodyApi);
    } else {
      responseBodyApi = await RoleApi.getUnSelectedUserInfo(requestBodyApi);
    }
    page = PageModel.fromJson(responseBodyApi.data);

    setState(() {});
  }

  _sort(column, {ascending}) {
    page.orders[0].column = column;
    page.orders[0].asc = ascending ?? !page.orders[0].asc;
    query();
  }

  _onPageChanged(int size, int current) {
    page.size = size;
    page.current = current;
    query();
  }
}
