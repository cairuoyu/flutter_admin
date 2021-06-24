/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:cry/cry.dart';
import 'package:cry/cry_button_bar.dart';
import 'package:cry/form1/cry_input.dart';
import 'package:cry/form1/cry_select.dart';
import 'package:cry/model/order_item_model.dart';
import 'package:cry/utils/cry_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/person_api.dart';
import 'package:cry/cry_button.dart';
import 'package:cry/cry_dialog.dart';
import 'package:flutter_admin/constants/constant_dict.dart';
import 'package:cry/model/page_model.dart';
import 'package:flutter_admin/models/person_model.dart';
import 'package:cry/model/request_body_api.dart';
import 'package:cry/model/response_body_api.dart';
import 'package:flutter_admin/utils/dict_util.dart';
import '../../generated/l10n.dart';
import 'person_dit.dart';

class PersonList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PersonListState();
  }
}

class PersonListState extends State {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int rowsPerPage = 10;
  MyDS myDS = new MyDS();
  PersonModel formData = PersonModel();

  _reset() {
    this.formData = PersonModel();
    formKey.currentState!.reset();
    myDS.requestBodyApi.params = formData.toMap();
    myDS.loadData();
  }

  _query() {
    formKey.currentState?.save();
    myDS.requestBodyApi.params = formData.toMap();
    myDS.loadData();
  }

  _edit({PersonModel? personModel}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: PersonEdit(
          personModel: personModel,
        ),
      ),
    ).then((v) {
      if (v != null) {
        _query();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    myDS.context = context;
    myDS.state = this;
    myDS.page.size = rowsPerPage;
    myDS.addListener(() {
      if (mounted) this.setState(() {});
    });
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
            label: S.of(context).personName,
            value: formData.name,
            onSaved: (v) {
              formData.name = v;
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

    var buttonBar = CryButtonBar(
      children: <Widget>[
        CryButton(label: S.of(context).query, iconData: Icons.search, onPressed: () => _query()),
        CryButton(label: S.of(context).reset, iconData: Icons.refresh, onPressed: () => _reset()),
        CryButton(label: S.of(context).add, iconData: Icons.add, onPressed: () => _edit()),
        CryButton(
          label: S.of(context).modify,
          iconData: Icons.edit,
          onPressed: myDS.selectedCount != 1
              ? null
              : () {
                  if (myDS.selectedRowCount != 1) {
                    return;
                  }
                  PersonModel personModel = myDS.dataList.firstWhere((v) {
                    return v.selected!;
                  });
                  _edit(personModel: personModel);
                },
        ),
        CryButton(
          label: S.of(context).delete,
          iconData: Icons.delete,
          onPressed: myDS.selectedCount < 1
              ? null
              : () {
                  cryConfirm(context, S.of(context).confirmDelete, (context) async {
                    List ids = myDS.dataList.where((v) {
                      return v.selected!;
                    }).map<String?>((v) {
                      return v.id;
                    }).toList();
                    var result = await PersonApi.removeByIds(ids);
                    if (result.success) {
                      _query();
                      CryUtils.message(S.of(Cry.context).success);
                    }
                  });
                },
        ),
      ],
    );

    Scrollbar table = Scrollbar(
      child: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          PaginatedDataTable(
            header: Text(S.of(context).userList),
            rowsPerPage: rowsPerPage,
            onRowsPerPageChanged: (int? value) {
              setState(() {
                if (value != null) {
                  rowsPerPage = value;
                  myDS.page.size = rowsPerPage;
                  myDS.loadData();
                }
              });
            },
            availableRowsPerPage: <int>[2, 5, 10, 20],
            onPageChanged: myDS.onPageChanged,
            columns: <DataColumn>[
              DataColumn(
                label: Text(S.of(context).name),
                onSort: (int columnIndex, bool ascending) => myDS.sort('name', ascending),
              ),
              DataColumn(
                label: Text(S.of(context).personNickname),
                onSort: (int columnIndex, bool ascending) => myDS.sort('nick_name', ascending),
              ),
              DataColumn(
                label: Text(S.of(context).personGender),
                onSort: (int columnIndex, bool ascending) => myDS.sort('gender', ascending),
              ),
              DataColumn(
                label: Text(S.of(context).personBirthday),
                onSort: (int columnIndex, bool ascending) => myDS.sort('birthday', ascending),
              ),
              DataColumn(
                label: Text(S.of(context).personDepartment),
                onSort: (int columnIndex, bool ascending) => myDS.sort('dept_id', ascending),
              ),
              DataColumn(
                label: Text(S.of(context).creationTime),
                onSort: (int columnIndex, bool ascending) => myDS.sort('create_time', ascending),
              ),
              DataColumn(
                label: Text(S.of(context).updateTime),
                onSort: (int columnIndex, bool ascending) => myDS.sort('update_time', ascending),
              ),
              DataColumn(
                label: Text(S.of(context).operating),
              ),
            ],
            source: myDS,
          ),
        ],
      ),
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          form,
          buttonBar,
          Expanded(
            child: table,
          ),
        ],
      ),
    );
  }
}

class MyDS extends DataTableSource {
  MyDS();

  late PersonListState state;
  late BuildContext context;
  late List<PersonModel> dataList;
  int selectedCount = 0;
  RequestBodyApi requestBodyApi = RequestBodyApi();
  PageModel page = PageModel(orders: [OrderItemModel(column: 'create_time', asc: false)]);

  sort(column, ascending) {
    page.orders[0].column = column;
    page.orders[0].asc = !page.orders[0].asc!;
    loadData();
  }

  loadData() async {
    requestBodyApi.page = page;
    ResponseBodyApi responseBodyApi = await PersonApi.page(requestBodyApi.toMap());
    page = PageModel.fromMap(responseBodyApi.data);

    dataList = page.records.map<PersonModel>((v) {
      PersonModel personModel = PersonModel.fromMap(v);
      personModel.selected = false;
      return personModel;
    }).toList();
    selectedCount = 0;
    notifyListeners();
  }

  onPageChanged(firstRowIndex) {
    page.current = firstRowIndex / page.size + 1;
    loadData();
  }

  @override
  DataRow? getRow(int index) {
    var dataIndex = index - page.size * (page.current - 1);

    if (dataIndex >= dataList.length) {
      return null;
    }
    PersonModel personModel = dataList[dataIndex];

    return DataRow.byIndex(
      index: index,
      selected: personModel.selected!,
      onSelectChanged: (bool? value) {
        personModel.selected = value;
        selectedCount += value! ? 1 : -1;
        notifyListeners();
      },
      cells: <DataCell>[
        DataCell(Text(personModel.name ?? '--')),
        DataCell(Text(personModel.nickName ?? '--')),
        DataCell(Text(DictUtil.getDictItemName(
          personModel.gender,
          ConstantDict.CODE_GENDER,
        )!)),
        DataCell(Text(personModel.birthday ?? '--')),
        DataCell(Text(DictUtil.getDictItemName(
          personModel.deptId,
          ConstantDict.CODE_DEPT,
          defaultValue: '--',
        )!)),
        DataCell(Text(personModel.createTime ?? '--')),
        DataCell(Text(personModel.updateTime ?? '--')),
        DataCell(ButtonBar(
          // alignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                state._edit(personModel: personModel);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                cryConfirm(context, S.of(context).confirmDelete, (context) async {
                  var result = await PersonApi.removeByIds([personModel.id]);
                  if (result.success) {
                    loadData();
                    CryUtils.message(S.of(Cry.context).success);
                  }
                });
              },
            ),
          ],
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => page.total;

  @override
  int get selectedRowCount => selectedCount;
}
