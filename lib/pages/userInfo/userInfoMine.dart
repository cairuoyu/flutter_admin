import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/userInfoApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/cryImageUpload.dart';
import 'package:flutter_admin/components/form2/crySelectDate.dart';
import 'package:flutter_admin/components/form2/crySelect.dart';
import 'package:flutter_admin/components/form2/cryInput.dart';
import 'package:flutter_admin/data/data1.dart';
import 'package:flutter_admin/models/configuration.dart';
import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:flutter_admin/models/userInfo.dart';
import '../../generated/l10n.dart';

class UserInfoMine extends StatefulWidget {
  UserInfoMine();

  @override
  _UserInfoMineState createState() => _UserInfoMineState();
}

class _UserInfoMineState extends State<UserInfoMine> {
  UserInfo userInfo = UserInfo();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    UserInfoApi.getCurrentUserInfo().then((res) {
      this.userInfo = UserInfo.fromJson(res.data);
      this.setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Wrap(
        children: <Widget>[
          SizedBox(
            child: CryImageUpload(
              updateAreaSize: 200,
              updateAreaDefault: Icon(Icons.person, size: 200),
              fileList: [this.userInfo?.avatarUrl],
              onUpload: (v) {
                this.userInfo.avatarUrl = v;
              },
            ),
          ),

          CryInput(
            label: S.of(context).personName,
            value: userInfo.name,
            onSaved: (v) => {userInfo.name = v},
            validator: (v) => v.isEmpty ? '必填' : null,
          ),
          CryInput(
            label: S.of(context).personNickname,
            value: userInfo.nickName,
            onSaved: (v) => {userInfo.nickName = v},
          ),
          CrySelectDate(
            label: S.of(context).personBirthday,
            context: context,
            value: userInfo.birthday,
            onSaved: (v) => {userInfo.birthday = v},
          ),
          CrySelect(
            label: S.of(context).personGender,
            dataList: Configuration.of(context).locale == 'en' ? genderList_en : genderList,
            value: userInfo.gender,
            onSaved: (v) => {userInfo.gender = v},
          ),
          CrySelect(
              label: S.of(context).personDepartment,
              dataList: Configuration.of(context).locale == 'en' ? deptIdList_en : deptIdList,
              value: userInfo.deptId,
              onSaved: (v) => {userInfo.deptId = v}),
          // CryInput(label: '籍贯'),
        ],
      ),
    );
    var buttonBar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        CryButton(
          label: S.of(context).save,
          onPressed: () {
            FormState form = formKey.currentState;
            if (!form.validate()) {
              return;
            }
            form.save();
            UserInfoApi.saveOrUpdate(this.userInfo.toJson()).then((ResponeBodyApi res) {
              if (!res.success) {
                return;
              }
              BotToast.showText(text: S.of(context).saved);
            });
          },
          iconData: Icons.save,
        ),
      ],
    );
    var result = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buttonBar,
        form,
      ],
    );
    return result;
  }
}
