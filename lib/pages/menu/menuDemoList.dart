import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/menuDemoApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/form2/cryInput.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/index.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/pages/menu/menuMenu.dart';
import 'package:flutter_admin/utils/adaptiveUtil.dart';
import 'package:flutter_admin/utils/treeUtil.dart';
import 'package:flutter_admin/vo/treeVO.dart';

class MenuDemoList extends StatefulWidget {
  MenuDemoList({Key key}) : super(key: key);

  @override
  _MenuDemoListState createState() => _MenuDemoListState();
}

class _MenuDemoListState extends State<MenuDemoList> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isEdit = false;
  Menu menuModel = Menu();
  List<TreeVO<Menu>> treeVOList;

  @override
  void initState() {
    super.initState();
    this._loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (this.isEdit && !isDisplayDesktop(context)) {
      return _getForm();
    }
    MenuMenu menuMenu = MenuMenu(
      expand: !isEdit,
      onEdit: (v) => _onEdit(v),
      reloadData: () {
        _loadData();
        setState(() {});
      },
      treeVOList: treeVOList,
    );
    var result = this.isEdit && isDisplayDesktop(context)
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [menuMenu, _getForm()],
          )
        : menuMenu;
    return result;
  }

  _loadData() async {
    ResponeBodyApi responeBodyApi = await MenuDemoApi.list(null);
    var data = responeBodyApi.data;
    List<Menu> list = List.from(data).map((e) => Menu.fromJson(e)).toList();
    this.treeVOList = TreeUtil<Menu>().toTreeVOList(list);
    this.setState(() {});
  }

  _onEdit(Menu menu) {
    this.menuModel = menu;
    this.isEdit = true;
    setState(() {});
  }

  _getForm() {
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
                MenuDemoApi.saveOrUpdate(menuModel.toJson()).then((res) {
                  BotToast.showText(text: S.of(context).saved);
                  setState(() {
                    this.isEdit = false;
                    _loadData();
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
                value: menuModel.pname ?? '根目录',
                label: '父菜单',
                onSaved: (v) {
                  menuModel.pname = v;
                },
              ),
              CryInput(
                value: menuModel.name,
                label: '菜单名',
                onSaved: (v) {
                  menuModel.name = v;
                },
                validator: (v) {
                  return v.isEmpty ? '必填' : null;
                },
              ),
              CryInput(
                value: menuModel.nameEn,
                label: '菜单英文名',
                onSaved: (v) {
                  menuModel.nameEn = v;
                },
              ),
              CryInput(
                value: menuModel.url,
                label: 'URL',
                onSaved: (v) {
                  menuModel.url = v;
                },
              ),
              CryInput(
                value: menuModel.remark,
                label: '备注',
                onSaved: (v) {
                  menuModel.remark = v;
                },
              ),
            ],
          ),
        )
      ],
    );
    return Expanded(
      child: form,
    );
  }
}
