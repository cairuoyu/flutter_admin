import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_admin/api/menuDemoApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/form2/cryInput.dart';
import 'package:flutter_admin/components/form2/cryInputNum.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:flutter_admin/models/responseBodyApi.dart';

class MenuForm extends StatefulWidget {
  MenuForm({Key key, this.menu, this.onSave, this.onClose}) : super(key: key);
  final Menu menu;
  final Function onSave;
  final Function onClose;

  @override
  _MenuFormState createState() => _MenuFormState();
}

class _MenuFormState extends State<MenuForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Menu menu;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    menu = widget.menu ?? Menu();
    var buttonBar = ButtonBar(
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
            MenuDemoApi.saveOrUpdate(menu.toJson()).then((ResponseBodyApi res) {
              if(!res.success){
                return ;
              }
              BotToast.showText(text: S.of(context).saved);
              if (widget.onSave != null) {
                widget.onSave();
              }
            });
          },
          iconData: Icons.save,
        ),
        CryButton(
            label: '取消',
            iconData: Icons.cancel,
            onPressed: () {
              if (widget.onClose != null) {
                widget.onClose();
              }
            }),
      ],
    );
    var form = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Form(
          key: formKey,
          child: Wrap(
            children: <Widget>[
              CryInput(
                enable: false,
                value: menu.pname ?? '根目录',
                label: '父菜单',
                onSaved: (v) {
                  menu.pname = v;
                },
              ),
              CryInput(
                value: menu.name,
                label: '菜单名',
                onSaved: (v) {
                  menu.name = v;
                },
                validator: (v) {
                  return v.isEmpty ? '必填' : null;
                },
              ),
              CryInput(
                value: menu.nameEn,
                label: '菜单英文名',
                onSaved: (v) {
                  menu.nameEn = v;
                },
              ),
              CryInput(
                value: menu.url,
                label: 'URL',
                onSaved: (v) {
                  menu.url = v;
                },
              ),
              CryInputNum(
                value: menu.orderBy,
                label: '顺序号',
                onSaved: (num v) {
                  menu.orderBy = v;
                },
              ),
              CryInput(
                value: menu.remark,
                label: '备注',
                onSaved: (v) {
                  menu.remark = v;
                },
              ),
            ],
          ),
        )
      ],
    );
    var result = Expanded(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: buttonBar,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [form],
          ),
        ),
      ),
    );
    return result;
  }
}
