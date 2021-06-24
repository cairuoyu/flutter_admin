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
import 'package:cry/form/cry_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/dept_api.dart';
import 'package:flutter_admin/constants/constant_dict.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/dept.dart';
import 'package:cry/utils/cry_utils.dart';
import 'package:flutter_admin/utils/dict_util.dart';

class DeptEdit extends StatefulWidget {
  final Dept? dept;

  DeptEdit({Key? key, this.dept}) : super(key: key);

  @override
  _DeptEditState createState() => _DeptEditState();
}

class _DeptEditState extends State<DeptEdit> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Dept dept;

  @override
  void initState() {
    dept = widget.dept ?? Dept();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Wrap(
        children: [
          CryInput(
            label: S.of(context).name,
            required: true,
            value: dept.name,
            onSaved: (v) {
              dept.name = v;
            },
          ),
          CryInput(
            label: S.of(context).nameShort,
            value: dept.nameShort,
            onSaved: (v) {
              dept.nameShort = v;
            },
          ),
          CrySelect(
            label: S.of(context).fun,
            dataList: DictUtil.getDictSelectOptionList(ConstantDict.CODE_DEPT_FUN),
            value: dept.fun,
            onSaved: (v) {
              dept.fun = v;
            },
          ),
          CryInput(
            label: S.of(context).header,
            value: dept.headerId,
            onSaved: (v) {
              dept.headerId = v;
            },
          ),
          CryInputNum(
            label: S.of(context).sequenceNumber,
            value: dept.orderBy,
            onSaved: (v) {
              dept.orderBy = v as int?;
            },
          ),
          CryInput(
            label: S.of(context).remarks,
            value: dept.remark,
            onSaved: (v) {
              dept.remark = v;
            },
          ),
        ],
      ),
    );

    var buttonBar = CryButtonBar(
      children: [
        CryButtons.save(context, () => save()),
        CryButtons.cancel(context, () => Navigator.pop(context)),
      ],
    );
    var result = Scaffold(
      appBar: AppBar(title: Text(S.of(context).add)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buttonBar,
            form,
          ],
        ),
      ),
    );
    return result;
  }

  save() async {
    var form = formKey.currentState!;
    if (!form.validate()) {
      return;
    }
    form.save();
    var res = await DeptApi.saveOrUpdate(dept.toMap());
    if (!res.success!) {
      return;
    }
    Navigator.pop(context, true);
    CryUtils.message(S.of(context).success);
  }
}
