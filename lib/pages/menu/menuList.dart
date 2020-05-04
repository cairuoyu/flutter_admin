import 'package:flutter/material.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/form2/cryInput.dart';
import 'package:flutter_admin/data/data1.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/vo/treeVO.dart';

class MenuList extends StatefulWidget {
  MenuList({Key key}) : super(key: key);

  @override
  MenuListState createState() => MenuListState();
}

class MenuListState extends State<MenuList> {
  List<TreeVO<Menu>> treeVOList = toTreeVOList(testMenuList);
  bool isEdit = false;
  Menu formData = Menu();

  List<TreeVO<Menu>> getSelected(List<TreeVO<Menu>> data) {
    var selected = List<TreeVO<Menu>>();
    data.forEach((element) {
      if (element.checked) {
        selected.add(element);
      }
      if (element.children != null && element.children.length > 0) {
        selected.addAll(getSelected(element.children));
      }
    });
    return selected;
  }

  @override
  Widget build(BuildContext context) {
    var selected = getSelected(treeVOList);
    var header = Container(
      decoration: getBD(),
      child: ListTile(
        title: ButtonBar(
          alignment: MainAxisAlignment.start,
          children: <Widget>[
            CryButton(
              iconData: Icons.add,
              label: '添加子菜单',
              onPressed: selected.length == 1
                  ? () {
                      this.setState(() {
                        this.isEdit = true;
                        this.formData = Menu(pid: selected[0].data.name);
                      });
                    }
                  : null,
            ),
            CryButton(
              iconData: Icons.delete,
              label: '删除',
              onPressed: selected.length >= 1 ? () {} : null,
            ),
          ],
        ),
      ),
    );
    ListView listView = ListView(
      children: [header, ...genListTile(treeVOList)],
    );
    var left = Container(
      width: 400,
      child: listView,
    );
    var right = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: <Widget>[
              CryButton(
                label: '保存',
                onPressed: () {},
                iconData: Icons.save,
              ),
              CryButton(
                  label: '取消',
                  iconData: Icons.cancel,
                  onPressed: () {
                    this.setState(() {
                      this.isEdit = false;
                    });
                  }),
            ],
          ),
          getForm(),
        ],
      ),
    );
    var result = this.isEdit
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [left, right],
          )
        : listView;
    return result;
  }

  Form getForm() {
    var form = Form(
      // key: formKey,
      child: Wrap(
        children: <Widget>[
          CryInput(
            value: formData.name,
            label: '菜单名',
            onSaved: (v) {
              formData.name = v;
            },
            validator: (v) {
              return v.isEmpty ? '必填' : null;
            },
          ),
          CryInput(
            value: formData.pid,
            label: '所属模块',
            onSaved: (v) {
              formData.pid = v;
            },
          ),
          CryInput(
            value: formData.url,
            label: 'URL',
            onSaved: (v) {
              formData.url = v;
            },
          ),
        ],
      ),
    );
    return form;
  }

  List<Widget> genListTile(List data) {
    List<Widget> list = [];
    for (var i = 0; i < data.length; i++) {
      TreeVO<Menu> vo = data[i];
      List<Widget> columnList = [getACell(vo.data.name)];
      if (!isEdit) {
        columnList.add(getACell(vo.data.url ?? '--'));
      }
      columnList.add(
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            setState(() {
              this.formData = vo.data;
              this.isEdit = true;
            });
          },
        ),
      );

      var title = Row(children: columnList);
      var leading = Checkbox(
          value: vo.checked,
          onChanged: (v) {
            setState(() {
              vo.checked = v;
              // checkChildren(vo, v);
            });
          });
      var d;
      if (vo.children != null && vo.children.length > 0) {
        d = Container(
          decoration: getBD(),
          child: ExpansionTile(
            leading: leading,
            children: genListTile(vo.children),
            title: title,
          ),
        );
      } else {
        d = Container(
          decoration: getBD(),
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
}

getACell(title, {width: 200}) {
  return Container(padding: EdgeInsets.symmetric(horizontal: 20), child: Text(title), width: width);
}

getBD({odd: true}) {
  var bd = BoxDecoration(
    boxShadow: [
      BoxShadow(color: Colors.black26, offset: Offset(2.0, 2.0), blurRadius: 4.0),
    ],
    color: odd ? Colors.white : Colors.white38,
    border: Border(bottom: BorderSide(color: Colors.black12)),
  );
  return bd;
}

checkChildren(TreeVO vo, bool v) {
  vo.checked = v;
  if (vo.children != null) {
    vo.children.forEach((c) {
      c.checked = v;
      checkChildren(c, v);
    });
  }
}

addMenu(List<TreeVO<Menu>> list, Menu menu) {
  TreeVO<Menu> treeVO = TreeVO(data: menu);
  for (var v in list) {
    if (v.data.pid == menu.id) {
      treeVO.children.add(v);
    }
  }
  for (var v in list) {
    if (v.data.id == menu.pid) {
      v.children.add(treeVO);
      return;
    }
  }
  list.add(treeVO);
}

List<TreeVO<Menu>> toTreeVOList(List<Menu> data) {
  List<TreeVO<Menu>> result = [];
  data.forEach((element) {
    addMenu(result, element);
  });
  return result;
}
