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
import 'package:intl/intl.dart';
import '../../generated/l10n.dart';

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
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => Login()));
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
          CryInput(
              label: S.of(context).personName,
              value: userInfo.name,
              onSaved: (v) => {userInfo.name = v}),
          CryInput(
              label: S.of(context).personNickname,
              value: userInfo.nickName,
              onSaved: (v) => {userInfo.nickName = v}),
          CrySelectDate(
            label: S.of(context).personBirthday,
            context: context,
            value: userInfo.birthday,
            onSaved: (v) => {userInfo.birthday = v},
          ),
          CrySelect(
              label: S.of(context).personGender,
              dataList: Intl.defaultLocale == 'en' ? genderList_en : genderList,
              value: userInfo.gender,
              onSaved: (v) => {userInfo.gender = v}),
          CrySelect(
              label: S.of(context).personDepartment,
              dataList: Intl.defaultLocale == 'en' ? deptIdList_en : deptIdList,
              value: userInfo.deptId,
              onSaved: (v) => {userInfo.deptId = v}),
          // CryInput(label: '籍贯'),
        ],
      ),
    );
    var b = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        CryButton(
          label: S.of(context).save,
          onPressed: () {
            FormState form = formKey.currentState;
            form.save();
            UserInfoApi.saveOrUpdate(userInfo.toJson()).then((res) {
              BotToast.showText(text: S.of(context).saved);
            });
          },
          iconData: Icons.save,
        )
      ],
    );
    var c = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[b, a, SizedBox(height: 20)],
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
