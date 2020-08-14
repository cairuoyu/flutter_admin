import 'package:flutter/material.dart';
import 'package:flutter_admin/models/index.dart' as model;

class CryDataTable<T> extends StatefulWidget {
  CryDataTable({
    Key key,
    this.title = '',
    this.columns,
    this.page,
    this.dataList,
    this.getCells,
  }) : super(key: key);
  final String title;
  final List<DataColumn> columns;
  final Function getCells;
  final model.Page page;
  final List<T> dataList;

  @override
  _CryDataTableState createState() => _CryDataTableState<T>();
}

class _CryDataTableState<T> extends State<CryDataTable> {
  _DS ds = _DS<T>();
  int rowsPerPage = 10;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ds._page = widget.page ?? model.Page();
    ds._getCells = widget.getCells;
    ds._dataList = widget.dataList ?? [];
    ds.reload();
    var result = ListView(
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        PaginatedDataTable(
          header: Text(widget.title),
          rowsPerPage: rowsPerPage,
          onRowsPerPageChanged: (int value) {
            setState(() {
              rowsPerPage = value;
            });
          },
          columns: widget.columns ?? [DataColumn(label: Text(''))],
          source: ds,
        )
      ],
    );
    return result;
  }
}

class _DS<T> extends DataTableSource {
  _DS() {}
  model.Page _page = model.Page();
  List<T> _dataList;
  int _selectedCount = 0;
  Function _getCells;

  reload() {
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    var dataIndex = index - _page.size * (_page.current - 1);

    if (dataIndex >= _dataList.length) {
      return null;
    }
    T t = _dataList[dataIndex];
    List<DataCell> cells = _getCells == null ? [] : _getCells(t);

    return DataRow.byIndex(
      index: index,
      cells: cells,
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _page.total;

  @override
  int get selectedRowCount => _selectedCount;
}
