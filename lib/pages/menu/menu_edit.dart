/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_button_bar.dart';
import 'package:cry/cry_buttons.dart';
import 'package:cry/form/cry_input.dart';
import 'package:cry/form/cry_input_num.dart';
import 'package:cry/form/cry_select_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_admin/api/menu_api.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/menu.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/pages/common/icon_selector.dart';
import 'package:cry/utils/cry_utils.dart';
import 'menu_selector.dart';

class MenuEdit extends StatefulWidget {
  MenuEdit({Key? key, this.menu, this.onSave, this.onClose}) : super(key: key);
  final Menu? menu;
  final Function? onSave;
  final Function? onClose;

  @override
  _MenuEditState createState() => _MenuEditState();
}

class _MenuEditState extends State<MenuEdit> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Menu menu;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    menu = widget.menu ?? Menu();
    var buttonBar = CryButtonBar(
      children: <Widget>[
        CryButtons.save(
          context,
          () {
            FormState form = formKey.currentState!;
            if (!form.validate()) {
              return;
            }
            form.save();
            MenuApi.saveOrUpdate(menu.toJson()).then((ResponseBodyApi res) {
              if (!res.success!) {
                return;
              }
              CryUtils.message(S.of(context).saved);
              if (widget.onSave != null) {
                widget.onSave!();
              }
            });
          },
        ),
        CryButtons.cancel(context, () {
          if (widget.onClose != null) {
            widget.onClose!();
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
              CrySelectCustomWidget<String>(
                context,
                label: S.of(context).parentMenu,
                initialValue: menu.pid,
                initialValueLabel: menu.pname ?? '根节点',
                popWidget: MenuSelector(
                  subsystemId: menu.subsystemId!,
                ),
                getValueLabel: (v) => v.name,
                getValue: (v) => v.id,
                onSaved: (v) {
                  menu.pid = v;
                },
              ),
              CryInput(
                value: menu.name,
                label: S.of(context).name,
                onSaved: (v) {
                  menu.name = v;
                },
                validator: (v) {
                  return v!.isEmpty ? S.of(context).required : null;
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
              CrySelectCustomWidget<String>(
                context,
                label: 'Icon',
                initialValue: menu.icon,
                initialValueLabel: menu.icon,
                popWidget: IconSelector(),
                getValueLabel: (v) => v,
                getValue: (v) => v,
                onSaved: (v) {
                  menu.icon = v;
                },
              ),
              CryInputNum(
                value: menu.orderBy,
                label: S.of(context).sequenceNumber,
                onSaved: (num? v) {
                  menu.orderBy = v as int?;
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
