import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/api/personApi.dart';
import 'package:flutter_admin/components/cryButton.dart';
import 'package:flutter_admin/components/cryDialog.dart';
import 'package:flutter_admin/components/form1/cryInput.dart';
import 'package:flutter_admin/components/form1/crySelect.dart';
import 'package:flutter_admin/data/data1.dart';
import 'package:flutter_admin/models/index.dart' as model;
import 'package:flutter_admin/models/requestBodyApi.dart';
import 'package:flutter_admin/models/responeBodyApi.dart';
import 'package:flutter_admin/utils/dictUtil.dart';
import 'package:intl/intl.dart';
import '../../generated/l10n.dart';

import 'personEdit.dart';

class PersonList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Curd1State();
  }
}

class Curd1State extends State {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int rowsPerPage = 10;
  MyDS myDS = new MyDS();
  model.Person formData = model.Person();

  reset() {
    this.formData = model.Person();
    formKey.currentState.reset();
    myDS.requestBodyApi.params = formData.toJson();
    myDS.loadData();
  }

  query() {
    formKey.currentState.save();
    myDS.requestBodyApi.params = formData.toJson();
    myDS.loadData();
  }

  @override
  void initState() {
    super.initState();
    myDS.context = context;
    myDS.page.size = rowsPerPage;
    myDS.page.orders.add(model.OrderItem(column: 'update_time', asc: false));
    myDS.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((c) {
      query();
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
            onSaved: (v) {
              formData.name = v;
            },
          ),
          CrySelect(
            label: S.of(context).personDepartment,
            value: formData.deptId,
            dataList: Intl.defaultLocale == 'en' ? deptIdList_en : deptIdList,
            onSaved: (v) {
              formData.deptId = v;
            },
          ),
        ],
      ),
    );

    ButtonBar buttonBar = ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        CryButton(
          label: S.of(context).inquire,
          onPressed: () {
            query();
          },
        ),
        CryButton(
          label: S.of(context).reset,
          onPressed: () {
            reset();
          },
        ),
        CryButton(
          label: S.of(context).increase,
          onPressed: () {
            cryDialog(
              width: 650,
              context: context,
              title: S.of(context).increase,
              body: EditPage(),
            ).then((v) {
              if (v != null) {
                query();
              }
            });
          },
        ),
        CryButton(
          label: S.of(context).modify,
          onPressed: myDS.selectedCount != 1
              ? null
              : () {
                  if (myDS.selectedRowCount != 1) {
                    return;
                  }
                  model.Person person = myDS.dataList.firstWhere((v) {
                    return v.selected;
                  });
                  cryDialog(
                    width: 650,
                    context: context,
                    title: S.of(context).modify,
                    body: EditPage(person: person),
                  ).then((v) {
                    if (v != null) {
                      query();
                    }
                  });
                },
        ),
        CryButton(
          label: S.of(context).delete,
          onPressed: myDS.selectedCount < 1
              ? null
              : () {
                  cryConfirm(context, S.of(context).confirmDelete, () async {
                    List ids = myDS.dataList.where((v) {
                      return v.selected;
                    }).map<String>((v) {
                      return v.id;
                    }).toList();
                    await PersonApi.removeByIds(ids);
                    query();
                    Navigator.of(context).pop();
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
            onRowsPerPageChanged: (int value) {
              setState(() {
                rowsPerPage = value;
                myDS.page.size = rowsPerPage;
                myDS.loadData();
              });
            },
            availableRowsPerPage: <int>[2, 5, 10, 20],
            onPageChanged: myDS.onPageChanged,
            columns: <DataColumn>[
              DataColumn(
                label: Text(S.of(context).name),
                onSort: (int columnIndex, bool ascending) =>
                    myDS.sort('name', ascending),
              ),
              DataColumn(
                label: Text(S.of(context).personNickname),
                onSort: (int columnIndex, bool ascending) =>
                    myDS.sort('nick_name', ascending),
              ),
              DataColumn(
                label: Text(S.of(context).personGender),
                onSort: (int columnIndex, bool ascending) =>
                    myDS.sort('gender', ascending),
              ),
              DataColumn(
                label: Text(S.of(context).personBirthday),
                onSort: (int columnIndex, bool ascending) =>
                    myDS.sort('birthday', ascending),
              ),
              DataColumn(
                label: Text(S.of(context).personDepartment),
                onSort: (int columnIndex, bool ascending) =>
                    myDS.sort('dept_id', ascending),
              ),
              DataColumn(
                label: Text(S.of(context).creationTime),
                onSort: (int columnIndex, bool ascending) =>
                    myDS.sort('create_time', ascending),
              ),
              DataColumn(
                label: Text(S.of(context).updateTime),
                onSort: (int columnIndex, bool ascending) =>
                    myDS.sort('update_time', ascending),
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
  BuildContext context;
  List<model.Person> dataList;
  int selectedCount = 0;
  RequestBodyApi requestBodyApi = RequestBodyApi();
  model.Page page = model.Page();
  sort(column, ascending) {
    page.orders[0].column = column;
    page.orders[0].asc = !page.orders[0].asc;
    loadData();
  }

  loadData() async {
    requestBodyApi.page = page;
    ResponeBodyApi responeBodyApi = await PersonApi.page(requestBodyApi);
    page = model.Page.fromJson(responeBodyApi.data);

    dataList = page.records.map<model.Person>((v) {
      model.Person person = model.Person.fromJson(v);
      person.selected = false;
      return person;
    }).toList();
    selectedCount = 0;
    notifyListeners();
  }

  onPageChanged(firstRowIndex) {
    page.current = firstRowIndex / page.size + 1;
    loadData();
  }

  @override
  DataRow getRow(int index) {
    var dataIndex = index - page.size * (page.current - 1);

    if (dataIndex >= dataList.length) {
      return null;
    }
    model.Person person = dataList[dataIndex];

    return DataRow.byIndex(
      index: index,
      selected: person.selected,
      onSelectChanged: (bool value) {
        person.selected = value;
        selectedCount += value ? 1 : -1;
        notifyListeners();
      },
      cells: <DataCell>[
        DataCell(Text(person.name ?? '--')),
        DataCell(Text(person.nickName ?? '--')),
        DataCell(Text(DictUtil.getDictName(person.gender,
            Intl.defaultLocale == 'en' ? genderList_en : genderList))),
        DataCell(Text(person.birthday ?? '--')),
        DataCell(Text(DictUtil.getDictName(person.deptId,
            Intl.defaultLocale == 'en' ? deptIdList_en : deptIdList,
            defaultValue: '--'))),
        DataCell(Text(person.createTime ?? '--')),
        DataCell(Text(person.updateTime ?? '--')),
        DataCell(ButtonBar(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                cryDialog(
                  width: 900,
                  context: context,
                  title: S.of(context).modify,
                  body: EditPage(person: person),
                ).then((v) {
                  if (v != null) {
                    loadData();
                  }
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                cryConfirm(context, S.of(context).confirmDelete, () async {
                  await PersonApi.removeByIds([person.id]);
                  loadData();
                  Navigator.of(context).pop();
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
