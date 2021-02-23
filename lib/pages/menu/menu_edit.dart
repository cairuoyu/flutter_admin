import 'package:bot_toast/bot_toast.dart';
import 'package:cry/cry_buttons.dart';
import 'package:cry/form/cry_input.dart';
import 'package:cry/form/cry_input_num.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_admin/api/menu_api.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:cry/model/response_body_api.dart';

class MenuEdit extends StatefulWidget {
  MenuEdit({Key key, this.menu, this.onSave, this.onClose}) : super(key: key);
  final Menu menu;
  final Function onSave;
  final Function onClose;

  @override
  _MenuEditState createState() => _MenuEditState();
}

class _MenuEditState extends State<MenuEdit> {
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
        CryButtons.save(
          context,
          () {
            FormState form = formKey.currentState;
            if (!form.validate()) {
              return;
            }
            form.save();
            MenuApi.saveOrUpdate(menu.toJson()).then((ResponseBodyApi res) {
              if (!res.success) {
                return;
              }
              BotToast.showText(text: S.of(context).saved);
              if (widget.onSave != null) {
                widget.onSave();
              }
            });
          },
        ),
        CryButtons.cancel(context, () {
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
                value: menu.pname ?? S.of(context).root,
                label: S.of(context).parentMenu,
                onSaved: (v) {
                  menu.pname = v;
                },
              ),
              CryInput(
                value: menu.name,
                label: S.of(context).name,
                onSaved: (v) {
                  menu.name = v;
                },
                validator: (v) {
                  return v.isEmpty ? S.of(context).required : null;
                },
              ),
              CryInput(
                value: menu.nameEn,
                label: S.of(context).englishName,
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
                label: S.of(context).sequenceNumber,
                onSaved: (num v) {
                  menu.orderBy = v;
                },
              ),
              CryInput(
                value: menu.remark,
                label: S.of(context).remarks,
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
