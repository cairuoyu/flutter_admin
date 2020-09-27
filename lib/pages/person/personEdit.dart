import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/personApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/form1/cryInput.dart';
import 'package:flutter_admin/components/form1/crySelect.dart';
import 'package:flutter_admin/components/form1/crySelectDate.dart';
import 'package:flutter_admin/constants/constantDict.dart';
import 'package:flutter_admin/models/person.dart';
import 'package:flutter_admin/utils/adaptiveUtil.dart';
import 'package:flutter_admin/utils/dictUtil.dart';
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
              return v.isEmpty ? S.of(context).personRequired : null;
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
            dataList: DictUtil.getDictSelectOptionList(ConstantDict.ID_GENDER),
            onSaved: (v) {
              formData.gender = v;
            },
          ),
          CrySelectDate(
            context: context,
            value: formData.birthday,
            label: S.of(context).personBirthday,
            onSaved: (v) {
              formData.birthday = v;
            },
          ),
          CrySelect(
            label: S.of(context).personDepartment,
            value: formData.deptId,
            dataList: DictUtil.getDictSelectOptionList(ConstantDict.ID_DEPT),
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
          label: S.of(context).save,
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
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
    var result = Scaffold(
      appBar: AppBar(
        title: Text(widget.person == null ? S.of(context).increase : S.of(context).modify),
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
