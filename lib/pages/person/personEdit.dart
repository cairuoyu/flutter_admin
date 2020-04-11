import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/personApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/form1/cryInput.dart';
import 'package:flutter_admin/components/form1/crySelect.dart';
import 'package:flutter_admin/components/form1/crySelectDate.dart';
import 'package:flutter_admin/data/data1.dart';
import 'package:flutter_admin/models/person.dart';

class EditPage extends StatefulWidget {
  final Person person;
  const EditPage({Key key, this.person}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return EditPageState();
  }
}

class EditPageState extends State<EditPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Person formData = Person();
  @override
  void initState() {
    super.initState();
    formData = widget.person;
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Wrap(
        children: <Widget>[
          CryInput(
            value: formData.name,
            label: '人员姓名',
            onSaved: (v) {
              formData.name = v;
            },
            validator: (v) {
              return v.isEmpty ? '必填' : null;
            },
          ),
          CryInput(
            value: formData.nickName,
            label: '呢称',
            onSaved: (v) {
              formData.nickName = v;
            },
          ),
          CrySelect(
            label: '性别',
            value: formData.gender,
            dataList: genderList,
            onSaved: (v) {
              formData.gender = v;
            },
          ),
          CrySelectDate(
            context: context,
            value: formData.birthday,
            label: '出生年月',
            onSaved: (v) {
              formData.birthday = v;
            },
          ),
          CrySelect(
            label: '所属部门',
            value: formData.deptId,
            dataList: deptIdList,
            onSaved: (v) {
              formData.deptId = v;
            },
          ),
        ],
      ),
    );
    ButtonBar buttonBar = ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        CryButton(
          label: '保存',
          onPressed: () {
            FormState form = formKey.currentState;
            if (!form.validate()) {
              return;
            }
            form.save();
            PersonApi.saveOrUpdate(formData.toJson()).then((res) {
              BotToast.showText(text: "保存成功");
              // BotToast.showSimpleNotification(title: "init");
              Navigator.pop(context, true);
            });
          },
        ),
        CryButton(
          label: '取消',
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
    DecoratedBox footer = DecoratedBox(
      decoration: BoxDecoration(color: Colors.white),
      child: buttonBar,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        form,
        SizedBox(height: 20),
        footer,
      ],
    );
  }
}
