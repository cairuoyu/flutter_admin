import 'package:flutter/material.dart';
import 'package:flutter_admin/api/menuDemoApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/cryDialog.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/vo/treeVO.dart';

class MenuMenu extends StatefulWidget {
  final bool expand;
  final Function onEdit;
  final VoidCallback reloadData;
  final List<TreeVO<Menu>> treeVOList;
  MenuMenu({this.expand = true, this.onEdit, this.treeVOList, this.reloadData});
  @override
  _MenuMenuState createState() => _MenuMenuState();
}

class _MenuMenuState extends State<MenuMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListView listView = ListView(
      children: [
        _getToolbars(),
        _getTableHeader(),
        _getTableBody(),
      ],
    );
    return Container(
      child: listView,
      width: widget.expand ? double.infinity : 450,
    );
  }

  _getToolbars() {
    var selected = _getSelected(widget.treeVOList);
    var result = Container(
      decoration: _getBoxDecoration(),
      child: ListTile(
        title: ButtonBar(
          alignment: MainAxisAlignment.start,
          children: <Widget>[
            CryButton(
              iconData: Icons.add,
              label: '添加菜单',
              onPressed: () => widget.onEdit(Menu()),
            ),
            CryButton(
              iconData: Icons.delete,
              label: '删除',
              onPressed: selected.length >= 1
                  ? () {
                      cryConfirm(context, S.of(context).confirmDelete, () async {
                        List ids = selected.map((e) => e.data.id).toList();
                        await MenuDemoApi.removeByIds(ids);
                        widget.reloadData();
                        Navigator.of(context).pop();
                      });
                    }
                  : null,
            ),
          ],
        ),
      ),
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
    List<Widget> list = [
      SizedBox(
        width: 100,
      ),
      _getCell("名称"),
    ];
    if (widget.expand) {
      list.add(_getCell("英文名"));
      list.add(_getCell("URL"));
      list.add(_getCell("备注"));
    }
    var d = Container(
      decoration: _getBoxDecoration(header: true),
      child: ListTile(
        leading: leading,
        title: Row(
          children: list,
        ),
      ),
    );
    return d;
  }

  Widget _getTableBody() {
    var rowList = _getRowList(widget.treeVOList ?? [], null);
    return Column(
      children: rowList,
    );
  }

  List<Widget> _getRowList(List<TreeVO<Menu>> data, TreeVO<Menu> parent) {
    List<Widget> list = [];
    for (var i = 0; i < data.length; i++) {
      TreeVO<Menu> vo = data[i];
      List<Widget> columnList = [];
      columnList.add(
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => widget.onEdit(Menu(pname: vo.data.name, pid: vo.data.id)),
        ),
      );
      columnList.add(
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Menu menu = vo.data;
            if (parent != null) {
              menu.pname = parent.data.name;
            }
            widget.onEdit(menu);
          },
        ),
      );

      columnList.add(_getCell(vo.data.name));
      if (widget.expand) {
        columnList.add(_getCell(vo.data.nameEn ?? '--'));
        columnList.add(_getCell(vo.data.url ?? '--'));
        columnList.add(_getCell(vo.data.remark ?? '--'));
      }
      var title = Row(children: columnList);
      var leading = Checkbox(
          value: vo.checked,
          onChanged: (v) {
            setState(() {
              vo.checked = v;
              // _checkChildren(vo, v);
            });
          });
      var d;
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

  _getCell(title, {width: 200.0}) {
    return Container(padding: EdgeInsets.symmetric(horizontal: 20), child: Text(title), width: width);
  }

  List<TreeVO<Menu>> _getSelected(List<TreeVO<Menu>> data) {
    if (data == null) {
      return [];
    }
    var selected = List<TreeVO<Menu>>();
    data.forEach((element) {
      if (element.checked) {
        selected.add(element);
      }
      if (element.children != null && element.children.length > 0) {
        selected.addAll(_getSelected(element.children));
      }
    });
    return selected;
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
