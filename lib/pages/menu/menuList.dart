import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/menuApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/form2/cryInput.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/index.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/vo/treeVO.dart';

class MenuList extends StatefulWidget {
  MenuList({Key key}) : super(key: key);

  @override
  MenuListState createState() => MenuListState();
}

class MenuListState extends State<MenuList> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<TreeVO<Menu>> treeVOList = [];
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

  loadData() async {
    ResponeBodyApi responeBodyApi = await MenuApi.list(null);
    var data = responeBodyApi.data;
    List<Menu> list = List.from(data).map((e) => Menu.fromJson(e)).toList();
    this.treeVOList = toTreeVOList(list);
    this.setState(() {});
  }

  @override
  void initState() {
    this.loadData();
    super.initState();
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
              label: '添加菜单',
              onPressed: () {
                this.setState(() {
                  this.isEdit = true;
                  this.formData = Menu();
                });
              },
            ),
            CryButton(
              iconData: Icons.delete,
              label: '删除',
              onPressed: selected.length >= 1
                  ? () async {
                      List ids = selected.map((e) => e.data.id).toList();
                      await MenuApi.removeByIds(ids);
                      setState(() {
                        this.loadData();
                      });
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
    ListView listView = ListView(
      children: [header, ...genListTile(treeVOList, null)],
    );
    var left = Container(
      width: 450,
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
                onPressed: () {
                  FormState form = formKey.currentState;
                  if (!form.validate()) {
                    return;
                  }
                  form.save();
                  MenuApi.saveOrUpdate(formData.toJson()).then((res) {
                    BotToast.showText(text: S.of(context).saved);
                    this.loadData();
                  });
                },
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
      key: formKey,
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
            enable: false,
            value: formData.pname ?? '根目录',
            label: '父菜单',
            onSaved: (v) {
              formData.pname = v;
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

  List<Widget> genListTile(List data, TreeVO<Menu> parent) {
    List<Widget> list = [];
    for (var i = 0; i < data.length; i++) {
      TreeVO<Menu> vo = data[i];
      List<Widget> columnList = [getACell(vo.data.name)];
      if (!isEdit) {
        columnList.add(getACell(vo.data.url ?? '--'));
      }
      columnList.add(
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              this.formData = Menu(pname: vo.data.name, pid: vo.data.id);
              this.isEdit = true;
            });
          },
        ),
      );
      columnList.add(
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            setState(() {
              this.formData = vo.data;
              if (parent != null) {
                this.formData.pname = parent.data.name;
              }
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
            initiallyExpanded: true,
            children: genListTile(vo.children, vo),
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

getACell(title, {width: 200.0}) {
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

findChildren(List<TreeVO<Menu>> list, TreeVO<Menu> treeVO) {
  for (var v in list) {
    if (v.data.pid == treeVO.data.id) {
      treeVO.children.add(v);
    }
    if (v.children.length > 0) {
      findChildren(v.children, treeVO);
    }
  }
}
findParent(List<TreeVO<Menu>> list, TreeVO<Menu> treeVO) {
  for (var v in list) {
    if (v.data.id == treeVO.data.pid) {
      v.children.add(treeVO);
      return;
    }
  }
}
addMenu(List<TreeVO<Menu>> list, Menu menu) {
  TreeVO<Menu> treeVO = TreeVO(data: menu);
  findChildren(list, treeVO);
  findParent(list, treeVO);
  list.add(treeVO);
}
List<TreeVO<Menu>> toTreeVOList(List<Menu> data) {
  List<TreeVO<Menu>> result = [];
  data.forEach((element) {
    addMenu(result, element);
  });
  return result.where((element) => element.data.pid == null).toList();
}
