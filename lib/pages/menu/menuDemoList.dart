import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/menuDemoApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/cryDialog.dart';
import 'package:flutter_admin/components/form2/cryInput.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/index.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/utils/adaptiveUtil.dart';
import 'package:flutter_admin/utils/treeUtil.dart';
import 'package:flutter_admin/vo/treeVO.dart';


class MenuDemoList extends StatefulWidget {
  MenuDemoList({Key key}) : super(key: key);

  @override
  MenuDemoListState createState() => MenuDemoListState();
}

class MenuDemoListState extends State<MenuDemoList> {
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
    ResponeBodyApi responeBodyApi = await MenuDemoApi.list(null);
    var data = responeBodyApi.data;
    List<Menu> list = List.from(data).map((e) => Menu.fromJson(e)).toList();
    this.treeVOList = new TreeUtil<Menu>().toTreeVOList(list);
    this.setState(() {});
  }

  @override
  void initState() {
    this.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (this.isEdit && !isDisplayDesktop(context)) {
      return getForm();
    }
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
                  ? () {
                      cryConfirm(context, S.of(context).confirmDelete, () async {
                        List ids = selected.map((e) => e.data.id).toList();
                        await MenuDemoApi.removeByIds(ids);
                        setState(() {
                          this.loadData();
                        });
                        Navigator.of(context).pop();
                      });
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
    ListView listView = ListView(
      children: [header, this.getListTileHeader(), ...getListTile(treeVOList, null)],
    );
    var left = Container(
      width: 450,
      child: listView,
    );
    var right = Expanded(
      child: getForm(),
    );
    var result = this.isEdit && isDisplayDesktop(context)
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [left, right],
          )
        : listView;
    return result;
  }

  getForm() {
    var form = Column(
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
                MenuDemoApi.saveOrUpdate(formData.toJson()).then((res) {
                  BotToast.showText(text: S.of(context).saved);
                  setState(() {
                    this.isEdit = false;
                    loadData();
                  });
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
        Form(
          key: formKey,
          child: Wrap(
            children: <Widget>[
              CryInput(
                enable: false,
                value: formData.pname ?? '根目录',
                label: '父菜单',
                onSaved: (v) {
                  formData.pname = v;
                },
              ),
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
                value: formData.nameEn,
                label: '菜单英文名',
                onSaved: (v) {
                  formData.nameEn = v;
                },
              ),
              CryInput(
                value: formData.url,
                label: 'URL',
                onSaved: (v) {
                  formData.url = v;
                },
              ),
              CryInput(
                value: formData.remark,
                label: '备注',
                onSaved: (v) {
                  formData.remark = v;
                },
              ),
            ],
          ),
        )
      ],
    );
    return form;
  }

  Widget getListTileHeader() {
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
      getACell("名称"),
    ];
    if (!isEdit && isDisplayDesktop(context)) {
      list.add(getACell("URL"));
      list.add(getACell("备注"));
    }
    var d = Container(
      decoration: getBD(header: true),
      child: ListTile(
        leading: leading,
        title: Row(
          children: list,
        ),
      ),
    );
    return d;
  }

  List<Widget> getListTile(List data, TreeVO<Menu> parent) {
    List<Widget> list = [];
    for (var i = 0; i < data.length; i++) {
      TreeVO<Menu> vo = data[i];
      List<Widget> columnList = [];
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

      columnList.add(getACell(vo.data.name));
      if (!isEdit && isDisplayDesktop(context)) {
        columnList.add(getACell(vo.data.url ?? '--'));
        columnList.add(getACell(vo.data.remark ?? '--'));
      }
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
            children: getListTile(vo.children, vo),
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

getBD({header: false, odd: true}) {
  var bd = BoxDecoration(
    boxShadow: [
      BoxShadow(color: Colors.black26, offset: Offset(2.0, 2.0), blurRadius: 4.0),
    ],
    color: header ? Colors.white60 : odd ? Colors.white : Colors.white38,
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
