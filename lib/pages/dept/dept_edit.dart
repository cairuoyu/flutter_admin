import 'package:cry/cry_buttons.dart';
import 'package:cry/form/cry_input.dart';
import 'package:cry/form/cry_input_num.dart';
import 'package:cry/form/cry_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/dept_api.dart';
import 'package:flutter_admin/constants/constant_dict.dart';
import 'package:flutter_admin/models/dept.dart';
import 'package:flutter_admin/utils/dict_util.dart';

class DeptEdit extends StatefulWidget {
  final Dept dept;

  DeptEdit({Key key, this.dept}) : super(key: key);

  @override
  _DeptEditState createState() => _DeptEditState();
}

class _DeptEditState extends State<DeptEdit> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Dept dept;

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
            label: '部门名称',
            required: true,
            value: dept.name,
            onSaved: (v) {
              dept.name = v;
            },
          ),
          CryInput(
            label: '部门简称',
            value: dept.nameShort,
            onSaved: (v) {
              dept.nameShort = v;
            },
          ),
          CrySelect(
            label: '部门职能',
            dataList: DictUtil.getDictSelectOptionList(ConstantDict.CODE_DEPT_FUN),
            value: dept.fun,
            onSaved: (v) {
              dept.fun = v;
            },
          ),
          CryInput(
            label: '部门领导',
            value: dept.headerId,
            onSaved: (v) {
              dept.headerId = v;
            },
          ),
          CryInputNum(
            label: '排序号',
            value: dept.orderBy,
            onSaved: (v) {
              dept.orderBy = v;
            },
          ),
          CryInput(
            label: '备注',
            value: dept.remark,
            onSaved: (v) {
              dept.remark = v;
            },
          ),
        ],
      ),
    );

    var buttonBar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        CryButtons.save(context, () => save()),
        CryButtons.cancel(context, () => close()),
      ],
    );
    var result = Column(
      children: [
        buttonBar,
        form,
      ],
    );
    return result;
  }

  save() async {
    var form = formKey.currentState;
    if (!form.validate()) {
      return;
    }
    form.save();
    var res = await DeptApi.saveOrUpdate(dept.toMap());
    if (!res.success) {
      return;
    }
    close();
  }

  close() {
    Navigator.pop(context);
  }
}
