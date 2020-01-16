import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/userInfoApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/form2/crySelectDate.dart';
import 'package:flutter_admin/components/form2/crySelect.dart';
import 'package:flutter_admin/components/form2/cryInput.dart';
import 'package:flutter_admin/data/data1.dart';
import 'package:flutter_admin/models/userInfo.dart';
import 'package:flutter_admin/pages/login.dart';

class UserInfoEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserInfoEditState();
  }
}

class UserInfoEditState extends State {
  UserInfo userInfo = new UserInfo();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    UserInfoApi.getCurrentUserInfo().then((v) {
      if (v.data == null) {
        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Login()));
      } else {
        setState(() {
          userInfo = UserInfo.fromJson(v.data);
        });
      }
    });
  }

  getBody() {
    var a = Form(
      key: formKey,
      child: Wrap(
        children: <Widget>[
          CryInput(label: '姓名', value: userInfo.name, onSaved: (v) => {userInfo.name = v}),
          CryInput(label: '呢称', value: userInfo.nickName, onSaved: (v) => {userInfo.nickName = v}),
          CrySelectDate(
              label: '出生年月', context: context, value: userInfo.birthday, onSaved: (v) => {userInfo.birthday = v}),
          CrySelect(label: '性别', dataList: genderList, value: userInfo.gender, onSaved: (v) => {userInfo.gender = v}),
          CrySelect(label: '部门', dataList: deptIdList, value: userInfo.deptId, onSaved: (v) => {userInfo.deptId = v}),
          // CryInput(label: '籍贯'),
        ],
      ),
    );
    var b = ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        CryButton(
          label: '保存',
          onPressed: () {
            FormState form = formKey.currentState;
            form.save();
            UserInfoApi.saveOrUpdate(userInfo.toJson()).then((res) {
              BotToast.showText(text: "保存成功");
            });
          },
          iconData: Icons.save,
        )
      ],
    );
    var c = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[a, SizedBox(height: 20), b],
    );
    return c;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }
}
