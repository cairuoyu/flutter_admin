import 'package:flutter/material.dart';
import 'package:flutter_admin/api/roleApi.dart';
import 'package:flutter_admin/components/cryDataTable.dart';
import 'package:flutter_admin/models/index.dart' as model;
import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:flutter_admin/models/role.dart';
import 'package:flutter_admin/models/userInfo.dart';

class RoleUserSelectList extends StatefulWidget {
  RoleUserSelectList({Key key, @required this.role, this.isSelected = false}) : super(key: key);
  final Role role;
  final bool isSelected;

  @override
  RoleUserSelectListState createState() => RoleUserSelectListState();
}

class RoleUserSelectListState extends State<RoleUserSelectList> {
  final GlobalKey<CryDataTableState> tableKey = GlobalKey<CryDataTableState>();
  model.Page page;

  @override
  void initState() {
    super.initState();
    page = model.Page(orders: [model.OrderItem(column: 'name')]);

    WidgetsBinding.instance.addPostFrameCallback((c) {
      query();
    });
  }

  @override
  Widget build(BuildContext context) {
    CryDataTable table = CryDataTable(
      key: tableKey,
      title: '角色',
      page: page,
      onPageChanged: _onPageChanged,
      onSelectChanged: (Map selected) {
        this.setState(() {});
      },
      columns: [
        DataColumn(
          label: Container(
            child: Text('名称'),
            width: 800,
          ),
        ),
      ],
      getCells: (Map m) {
        UserInfo userInfo = model.UserInfo.fromJson(m);
        return [
          DataCell(Container(width: 800, child: Text(userInfo.name ?? '--'))),
        ];
      },
    );
    var result = Expanded(
      child: table,
    );
    return result;
  }

  List<UserInfo> getSelectedList() {
    List<UserInfo> selectedList =
        tableKey?.currentState?.getSelectedList(page)?.map<UserInfo>((e) => UserInfo.fromJson(e))?.toList() ?? [];
    return selectedList;
  }

  query() async {
    model.RequestBodyApi requestBodyApi = model.RequestBodyApi();
    requestBodyApi.page = page;
    requestBodyApi.params = widget.role.toJson();
    ResponeBodyApi responeBodyApi;
    if (widget.isSelected) {
      responeBodyApi = await RoleApi.getSelectedUserInfo(requestBodyApi);
    } else {
      responeBodyApi = await RoleApi.getUnSelectedUserInfo(requestBodyApi);
    }
    page = model.Page.fromJson(responeBodyApi.data);

    setState(() {});
  }

  _onPageChanged(int current) {
    page.current = current;
    query();
  }
}
