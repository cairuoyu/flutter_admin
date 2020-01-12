import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/userInfoApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/cryInput.dart';
import 'package:flutter_admin/components/crySelect.dart';
import 'package:flutter_admin/components/crySelectDate.dart';
import 'package:flutter_admin/data/data1.dart';
import 'package:flutter_admin/models/index.dart';
import 'package:flutter_admin/models/userInfo.dart';

class EditPage extends StatefulWidget {
  final String id;
  const EditPage({Key key, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return EditPageState();
  }
}

class EditPageState extends State<EditPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserInfo formData = UserInfo();
  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      UserInfoApi.getById({'id': widget.id}).then((ResponeBodyApi res) {
        formData = UserInfo.fromJson(res.data);
        setState(() {});
      });
    }
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
          ),
          CryInput(
            value: formData.nickName,
            label: '呢称',
            onSaved: (v) {
              formData.nickName= v;
            },
          ),
          CrySelect(
            label: '性别',
            value: formData.gender,
            dataList: genderList,
            onSaved: (v) {
              formData.gender= v;
            },
          ),
          CrySelectDate(
            context: context,
            value: formData.birthday,
            label: '出生年月',
            onSaved: (v) {
              formData.birthday= v;
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
          text: '保存',
          onPressed: () {
            FormState form = formKey.currentState;
            form.save();
            UserInfoApi.saveOrUpdate(formData.toJson()).then((res) {
              BotToast.showText(text: "保存成功");
              Navigator.pop(context, true);
            });
          },
        ),
        CryButton(text: '取消',onPressed: (){
          Navigator.pop(context);
        },)
      ],
    );
    DecoratedBox footer = DecoratedBox(decoration: BoxDecoration(color: Colors.white),child: buttonBar,);
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
