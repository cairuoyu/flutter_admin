import 'package:flutter/material.dart';
import 'package:flutter_admin/vo/treeVO.dart';

class CryTreeTableColumnData {
  CryTreeTableColumnData(this.label, this.getData, {this.width = 200});
  Function getData;
  String label;
  double width;
}

class CryTreeTable<T extends TreeData> extends StatefulWidget {
  CryTreeTable({
    Key key,
    this.columnData,
    this.data,
    this.toolbars,
    this.getRowOper,
    this.onSelected,
    this.width = 1000,
    this.tableWidth = 1000,
  }) : super(key: key);
  final List<CryTreeTableColumnData> columnData;
  final List<TreeVO<T>> data;
  final Widget toolbars;
  final Function getRowOper;
  final Function onSelected;
  final double width;
  final double tableWidth;

  @override
  CryTreeTableState createState() => CryTreeTableState<T>();
}

class CryTreeTableState<T extends TreeData> extends State<CryTreeTable<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Column c = Column(
      children: [
        _getToolbars(),
        _getTableHeader(),
        _getTableBody(),
      ],
    );
    var s = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: widget.tableWidth,
        child: c,
      ),
    );

    return Container(
      child: ListView(
        children: [s],
      ),
      width: widget.width,
      decoration: _getBoxDecoration(),
    );
  }

  _getToolbars() {
    var result = Container(
      decoration: _getBoxDecoration(),
      child: widget.toolbars,
    );
    return result;
  }

  Widget _getTableHeader() {
    var leading = Checkbox(
        value: false,
        onChanged: (v) {
          setState(() {
            // checkChildren(vo, v);
          });
        });
    List<Widget> list = [];
    widget.columnData.forEach((element) {
      list.add(_getCell(element.label, width: element.width));
    });
    if (widget.getRowOper != null) {
      list.insert(0, _getCell('操作', width: 100));
    }
    var result = Container(
      decoration: _getBoxDecoration(header: true),
      child: ListTile(
        leading: leading,
        title: Row(
          children: list,
        ),
      ),
    );
    return result;
  }

  Widget _getTableBody() {
    var rowList = _getRowList(widget.data ?? [], null);
    return Column(
      children: rowList,
    );
  }

  List<Widget> _getRowList(List<TreeVO<T>> data, TreeVO<T> parent) {
    List<Widget> list = [];
    for (var i = 0; i < data.length; i++) {
      TreeVO<T> vo = data[i];
      List<Widget> columnList = [];
      columnList = widget.columnData
          .map<Widget>(
            (v) => _getCell(v.getData(vo.data), width: v.width),
          )
          .toList();

      if (widget.getRowOper != null) {
        var s = SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: 100,
            child: Row(
              children: widget.getRowOper(vo, parent),
            ),
          ),
        );
        columnList.insert(0, s);
      }

      var title = Row(children: columnList);
      var leading = Checkbox(
          value: vo.checked,
          onChanged: (v) {
            setState(() {
              vo.checked = v;
              if (widget.onSelected != null) {
                widget.onSelected(vo);
              }
              // _checkChildren(vo, v);
            });
          });
      Widget d;
      if (vo.children != null && vo.children.length > 0) {
        d = Container(
          decoration: _getBoxDecoration(),
          child: ExpansionTile(
            leading: leading,
            initiallyExpanded: true,
            children: _getRowList(vo.children, vo),
            title: title,
          ),
        );
      } else {
        d = Container(
          decoration: _getBoxDecoration(),
          child: ListTile(
            leading: leading,
            title: title,
          ),
        );
      }
      list.add(d);
    }
    return list;
  }

  _getBoxDecoration({header: false, odd: true}) {
    var bd = BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(2.0, 2.0), blurRadius: 4.0),
      ],
      color: header ? Colors.white60 : odd ? Colors.white : Colors.white38,
      border: Border(bottom: BorderSide(color: Colors.black12)),
    );
    return bd;
  }

  _getCell(title, {width: 200.0}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(title),
      width: width,
    );
  }
  // _checkChildren(TreeVO vo, bool v) {
  //   vo.checked = v;
  //   if (vo.children != null) {
  //     vo.children.forEach((c) {
  //       c.checked = v;
  //       _checkChildren(c, v);
  //     });
  //   }
  // }
}
