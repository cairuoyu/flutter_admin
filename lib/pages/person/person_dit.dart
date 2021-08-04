/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/form1/cry_input.dart';
import 'package:cry/form1/cry_select.dart';
import 'package:cry/form1/cry_select_date.dart';
import 'package:cry/utils/adaptive_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/person_api.dart';
import 'package:cry/cry_button.dart';
import 'package:flutter_admin/constants/constant_dict.dart';
import 'package:flutter_admin/models/person_model.dart';
import 'package:cry/utils/cry_utils.dart';
import 'package:flutter_admin/utils/dict_util.dart';
import '../../generated/l10n.dart';

class PersonEdit extends StatefulWidget {
  final PersonModel? personModel;

  const PersonEdit({Key? key, this.personModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PersonEditState();
  }
}

class PersonEditState extends State<PersonEdit> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PersonModel? _personModel = PersonModel();

  @override
  void initState() {
    super.initState();
    if (widget.personModel != null) {
      _personModel = widget.personModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Wrap(
        children: <Widget>[
          CryInput(
            value: _personModel!.name,
            label: S.of(context).personName,
            onSaved: (v) {
              _personModel!.name = v;
            },
            validator: (v) {
              return v!.isEmpty ? S.of(context).required : null;
            },
          ),
          CryInput(
            value: _personModel!.nickName,
            label: S.of(context).personNickname,
            onSaved: (v) {
              _personModel!.nickName = v;
            },
          ),
          CrySelect(
            label: S.of(context).personGender,
            value: _personModel!.gender,
            dataList: DictUtil.getDictSelectOptionList(ConstantDict.CODE_GENDER),
            onSaved: (v) {
              _personModel!.gender = v;
            },
          ),
          CrySelectDate(
            context,
            value: _personModel!.birthday,
            label: S.of(context).personBirthday,
            onSaved: (v) {
              _personModel!.birthday = v;
            },
          ),
          CrySelect(
            label: S.of(context).personDepartment,
            value: _personModel!.deptId,
            dataList: DictUtil.getDictSelectOptionList(ConstantDict.CODE_DEPT),
            onSaved: (v) {
              _personModel!.deptId = v;
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
          iconData: Icons.save,
          onPressed: () {
            FormState form = formKey.currentState!;
            if (!form.validate()) {
              return;
            }
            form.save();
            PersonApi.saveOrUpdate(_personModel!.toMap()).then((res) {
              Navigator.pop(context, true);
              CryUtils.message(S.of(context).saved);
            });
          },
        ),
        CryButton(
          label: S.of(context).cancel,
          iconData: Icons.cancel,
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
    var result = Scaffold(
      appBar: AppBar(
        title: Text(widget.personModel == null ? S.of(context).add : S.of(context).modify),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            form,
          ],
        ),
      ),
      bottomNavigationBar: buttonBar,
    );
    return SizedBox(
      width: 650,
      height: isDisplayDesktop(context) ? 350 : 500,
      child: result,
    );
  }
}
