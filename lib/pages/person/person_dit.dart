import 'package:bot_toast/bot_toast.dart';
import 'package:cry/form1/cry_input.dart';
import 'package:cry/form1/cry_select.dart';
import 'package:cry/form1/cry_select_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/person_api.dart';
import 'package:cry/cry_button.dart';
import 'package:flutter_admin/constants/constant_dict.dart';
import 'package:flutter_admin/models/person.dart';
import 'package:flutter_admin/utils/adaptive_util.dart';
import 'package:flutter_admin/utils/dict_util.dart';
import '../../generated/l10n.dart';

class PersonEdit extends StatefulWidget {
  final Person person;

  const PersonEdit({Key key, this.person}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PersonEditState();
  }
}

class PersonEditState extends State<PersonEdit> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Person formData = Person();

  @override
  void initState() {
    super.initState();
    if (widget.person != null) {
      formData = widget.person;
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
            label: S.of(context).personName,
            onSaved: (v) {
              formData.name = v;
            },
            validator: (v) {
              return v.isEmpty ? S.of(context).required : null;
            },
          ),
          CryInput(
            value: formData.nickName,
            label: S.of(context).personNickname,
            onSaved: (v) {
              formData.nickName = v;
            },
          ),
          CrySelect(
            label: S.of(context).personGender,
            value: formData.gender,
            dataList: DictUtil.getDictSelectOptionList(ConstantDict.CODE_GENDER),
            onSaved: (v) {
              formData.gender = v;
            },
          ),
          CrySelectDate(
            context,
            value: formData.birthday,
            label: S.of(context).personBirthday,
            onSaved: (v) {
              formData.birthday = v;
            },
          ),
          CrySelect(
            label: S.of(context).personDepartment,
            value: formData.deptId,
            dataList: DictUtil.getDictSelectOptionList(ConstantDict.CODE_DEPT),
            onSaved: (v) {
              formData.deptId = v;
            },
          ),
        ],
      ),
    );
    var  buttonBar = ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        CryButton(
          label: S.of(context).save,
          iconData: Icons.save,
          onPressed: () {
            FormState form = formKey.currentState;
            if (!form.validate()) {
              return;
            }
            form.save();
            PersonApi.saveOrUpdate(formData.toJson()).then((res) {
              BotToast.showText(text: S.of(context).saved);
              // BotToast.showSimpleNotification(title: "init");
              Navigator.pop(context, true);
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
        title: Text(widget.person == null ? S.of(context).add : S.of(context).modify),
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
