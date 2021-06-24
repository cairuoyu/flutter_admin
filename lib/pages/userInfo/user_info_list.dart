/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry_button_bar.dart';
import 'package:cry/cry_buttons.dart';
import 'package:cry/form/cry_input.dart';
import 'package:cry/form/cry_select_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/user_info_api.dart';
import 'package:cry/cry_button.dart';
import 'package:cry/cry_data_table.dart';
import 'package:flutter_admin/constants/constant_dict.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:cry/model/page_model.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/models/dept.dart';
import 'package:flutter_admin/models/user_info.dart';
import 'package:flutter_admin/pages/common/dept_selector.dart';
import 'package:flutter_admin/pages/userInfo/user_info_edit.dart';
import 'package:flutter_admin/utils/dict_util.dart';
import 'package:flutter_admin/utils/utils.dart';

class UserInfoList extends StatefulWidget {
  UserInfoList({Key? key}) : super(key: key);

  @override
  _UserInfoListState createState() => _UserInfoListState();
}

class _UserInfoListState extends State<UserInfoList> {
  final GlobalKey<CryDataTableState> tableKey = GlobalKey<CryDataTableState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PageModel page = PageModel();
  UserInfo userInfo = UserInfo();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((c) {
      _query();
    });
  }

  @override
  Widget build(BuildContext context) {
    var form = Form(
      key: formKey,
      child: Wrap(
        children: <Widget>[
          CryInput(
            width: 400,
            label: S.of(context).name,
            value: userInfo.name,
            onSaved: (v) {
              userInfo.name = v;
            },
          ),
          CrySelectCustomWidget<Dept>(
            context,
            width: 400,
            initialValue: Dept(id: userInfo.id, name: userInfo.deptName),
            label: S.of(context).personDepartment,
            popWidget: DeptSelector(),
            getValueLabel: (Dept d) => d.name,
            getValue: (Dept d) => d,
            onSaved: (Dept? v) {
              userInfo.deptId = v!.id;
              userInfo.deptName = v.name;
            },
          ),
        ],
      ),
    );
    CryDataTable table = CryDataTable(
      key: tableKey,
      title: S.of(context).userList,
      onPageChanged: (firstRowIndex) {
        page.current = (firstRowIndex ~/ page.size + 1);
        _loadData();
      },
      onRowsPerPageChanged: (int size) {
        page.size = size;
        page.current = 1;
        _loadData();
      },
      onSelectChanged: (Map selected) {
        this.setState(() {});
      },
      columns: [
        DataColumn(
          label: Text(S.of(context).operating),
        ),
        DataColumn(
          label: Text(S.of(context).username),
          onSort: (int columnIndex, bool ascending) => _sort('user_name'),
        ),
        DataColumn(
          label: Text(S.of(context).name),
          onSort: (int columnIndex, bool ascending) => _sort('name'),
        ),
        DataColumn(
          label: Text(S.of(context).personNickname),
          onSort: (int columnIndex, bool ascending) => _sort('nick_name'),
        ),
        DataColumn(
          label: Text(S.of(context).personGender),
          onSort: (int columnIndex, bool ascending) => _sort('gender'),
        ),
        DataColumn(
          label: Text(S.of(context).hometown),
          onSort: (int columnIndex, bool ascending) => _sort('hometown'),
        ),
        DataColumn(
          label: Text(S.of(context).personBirthday),
          onSort: (int columnIndex, bool ascending) => _sort('birthday'),
        ),
        DataColumn(
          label: Text(S.of(context).personDepartment),
          onSort: (int columnIndex, bool ascending) => _sort('dept_id'),
        ),
        DataColumn(
          label: Text(S.of(context).creationTime),
          onSort: (int columnIndex, bool ascending) => _sort('create_time'),
        ),
        DataColumn(
          label: Text(S.of(context).updateTime),
          onSort: (int columnIndex, bool ascending) => _sort('update_time'),
        ),
      ],
      getCells: (m) {
        UserInfo userInfo = UserInfo.fromMap(m);
        return [
          DataCell(
            CryButtonBar(
              children: [
                CryButton(iconData: Icons.edit, tip: S.of(context).modify, onPressed: () => _edit(userInfo)),
              ],
            ),
          ),
          DataCell(Text(userInfo.userName ?? '--')),
          DataCell(Text(userInfo.name ?? '--')),
          DataCell(Text(userInfo.nickName ?? '--')),
          DataCell(Text(DictUtil.getDictItemName(
            userInfo.gender,
            ConstantDict.CODE_GENDER,
          )!)),
          DataCell(Text(userInfo.hometown ?? '--')),
          DataCell(Text(userInfo.birthday ?? '--')),
          DataCell(Text(userInfo.deptName ?? '--')),
          DataCell(Text(userInfo.createTime ?? '--')),
          DataCell(Text(userInfo.updateTime ?? '--')),
        ];
      },
    );
    List<UserInfo> selectedList = tableKey.currentState?.getSelectedList(page).map<UserInfo>((e) => UserInfo.fromMap(e)).toList() ?? [];
    CryButtonBar buttonBar = CryButtonBar(
      children: <Widget>[
        CryButtons.query(context, () => _query()),
        CryButtons.reset(context, () => _reset()),
        CryButtons.add(context, () => _edit(null)),
        CryButtons.edit(context, selectedList.length != 1 ? null : () => _edit(selectedList[0])),
      ],
    );
    var result = Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          form,
          buttonBar,
          Expanded(child: SingleChildScrollView(child: table)),
        ],
      ),
    );
    return result;
  }

  _edit(UserInfo? userInfo) async {
    var result = await Utils.fullscreenDialog(UserInfoEdit(userInfo: userInfo));
    if (result ?? false) {
      userInfo == null ? _sort('create_time', ascending: false) : _sort('update_time', ascending: false);
    }
  }

  _reset() {
    userInfo = UserInfo();
    formKey.currentState!.reset();
    _loadData();
  }

  _query() {
    formKey.currentState?.save();
    tableKey.currentState?.pageTo(0);
    _loadData();
  }

  _loadData() async {
    ResponseBodyApi responseBodyApi = await UserInfoApi.page(RequestBodyApi(page: page, params: userInfo.toMap()).toMap());
    page = responseBodyApi.data != null ? PageModel.fromMap(responseBodyApi.data) : PageModel();
    tableKey.currentState!.loadData(page);
  }

  _sort(column, {ascending}) {
    page.orders[0].column = column;
    page.orders[0].asc = ascending ?? !page.orders[0].asc!;
    _query();
  }
}
