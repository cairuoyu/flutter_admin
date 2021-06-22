/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_all.dart';
import 'package:cry/data/location.dart';
import 'package:cry/model/cascade_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/user_info_api.dart';
import 'package:cry/cry_button.dart';
import 'package:flutter_admin/constants/constant_dict.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/models/dept.dart';
import 'package:flutter_admin/models/user_info.dart';
import 'package:flutter_admin/pages/common/dept_selector.dart';
import 'package:cry/utils/cry_utils.dart';
import 'package:flutter_admin/utils/dict_util.dart';
import '../../generated/l10n.dart';

class UserInfoEdit extends StatefulWidget {
  UserInfoEdit({this.userInfo});

  final UserInfo? userInfo;

  @override
  _UserInfoEditState createState() => _UserInfoEditState();
}

class _UserInfoEditState extends State<UserInfoEdit> {
  late UserInfo userInfo;
  bool? isAdd;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    this.isAdd = widget.userInfo == null;
    this.userInfo = widget.userInfo ?? UserInfo();
  }

  @override
  Widget build(BuildContext context) {
    var hometownData = pca.map((e) => CascadeModel.fromMap(e)).toList();
    var form = Form(
      key: formKey,
      child: Wrap(
        children: <Widget>[
          CryInput(
            label: S.of(context).username,
            value: userInfo.userName,
            onSaved: (v) => {userInfo.userName = v},
            validator: (v) => this.isAdd! && v!.isEmpty ? S.of(context).required : null,
            enable: this.isAdd,
          ),
          CryInput(
            label: S.of(context).personName,
            value: userInfo.name,
            onSaved: (v) => {userInfo.name = v},
          ),
          CryInput(
            label: S.of(context).personNickname,
            value: userInfo.nickName,
            onSaved: (v) => {userInfo.nickName = v},
          ),
          CrySelectCustomWidget(
            context,
            initialValue: userInfo.hometown,
            initialValueLabel: userInfo.hometown,
            label: S.of(context).hometown,
            key: UniqueKey(),
            popWidget: CryCascade(
              data: hometownData,
              title: '中国',
            ),
            getValue: (List<CascadeModel> v) => v.map((e) => e.name).toList().join(','),
            getValueLabel: (List<CascadeModel> v) => v.map((e) => e.name).toList().join(','),
            onSaved: (dynamic v) {
              userInfo.hometown = v;
            },
          ),
          CrySelectDate(
            context,
            label: S.of(context).personBirthday,
            value: userInfo.birthday,
            onSaved: (v) => {userInfo.birthday = v},
          ),
          CrySelect(
            label: S.of(context).personGender,
            dataList: DictUtil.getDictSelectOptionList(ConstantDict.CODE_GENDER),
            value: userInfo.gender,
            onSaved: (v) => {userInfo.gender = v},
          ),
          CrySelectCustomWidget(
            context,
            label: S.of(context).personDepartment,
            initialValue: userInfo.deptId,
            initialValueLabel: userInfo.deptName,
            popWidget: DeptSelector(),
            getValueLabel: (Dept d) => d.name,
            getValue: (Dept d) => d.id,
            onSaved: (dynamic v) {
              userInfo.deptId = v;
            },
          ),
        ],
      ),
    );
    var buttonBar = ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        CryButton(
          label: S.of(context).save,
          onPressed: () {
            FormState form = formKey.currentState!;
            if (!form.validate()) {
              return;
            }
            form.save();
            UserInfoApi.saveOrUpdate(userInfo.toMap()).then((ResponseBodyApi res) {
              if (!res.success!) {
                return;
              }
              Navigator.pop(context, true);
              CryUtils.message(S.of(context).saved);
            });
          },
          iconData: Icons.save,
        ),
        CryButton(
          label: S.of(context).cancel,
          onPressed: () {
            Navigator.pop(context);
          },
          iconData: Icons.cancel,
        )
      ],
    );
    var result = Scaffold(
      appBar: AppBar(
        title: Text(this.isAdd! ? S.of(context).add : S.of(context).modify),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [form],
        ),
      ),
      bottomNavigationBar: buttonBar,
    );
    return SizedBox(
      width: 650,
      height: 650,
      child: result,
    );
    // return result;
  }
}
