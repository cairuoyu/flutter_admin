import 'package:cry/model/order_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/role_api.dart';
import 'package:cry/cry_data_table.dart';
import 'package:cry/model/page_model.dart';
import 'package:flutter_admin/models/request_body_api.dart';
import 'package:flutter_admin/models/response_body_api.dart';
import 'package:flutter_admin/models/role.dart';
import 'package:flutter_admin/models/menu.dart';

class RoleMenuSelectList extends StatefulWidget {
  RoleMenuSelectList({
    Key key,
    @required this.role,
    this.isSelected = false,
    this.title,
  }) : super(key: key);
  final Role role;
  final bool isSelected;
  final String title;

  @override
  RoleMenuSelectListState createState() => RoleMenuSelectListState();
}

class RoleMenuSelectListState extends State<RoleMenuSelectList> {
  final GlobalKey<CryDataTableState> tableKey = GlobalKey<CryDataTableState>();
  PageModel page;

  @override
  void initState() {
    super.initState();
    page = PageModel(orders: [OrderItemModel(column: 'name')]);

    WidgetsBinding.instance.addPostFrameCallback((c) {
      query();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          label: Container(
            child: Text('名称'),
            width: 800,
          ),
        ),
      ],
      getCells: (Map m) {
        Menu menu = Menu.fromMap(m);
        return [
          DataCell(Container(width: 800, child: Text(menu.name ?? '--'))),
        ];
      },
    );
    var result = Expanded(
      child: table,
    );
    return result;
  }

  List<Menu> getSelectedList() {
    List<Menu> selectedList =
        tableKey?.currentState?.getSelectedList(page)?.map<Menu>((e) => Menu.fromMap(e))?.toList() ?? [];
    return selectedList;
  }

  query() async {
    RequestBodyApi requestBodyApi = RequestBodyApi();
    requestBodyApi.page = page;
    requestBodyApi.params = widget.role.toJson();
    ResponseBodyApi responseBodyApi;
    if (widget.isSelected) {
      responseBodyApi = await RoleApi.getSelectedMenu(requestBodyApi.toMap());
    } else {
      responseBodyApi = await RoleApi.getUnSelectedMenu(requestBodyApi.toMap());
    }
    page = PageModel.fromMap(responseBodyApi.data);

    setState(() {});
  }

  _onPageChanged(int size, int current) {
    page.size = size;
    page.current = current;
    query();
  }
}
