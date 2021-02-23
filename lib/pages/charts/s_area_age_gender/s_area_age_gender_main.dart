import 'package:flutter/material.dart';
import 'package:flutter_admin/api/s_area_age_gender.dart';
import 'package:flutter_admin/constants/enum.dart';
import 'package:flutter_admin/models/s_area_age_gender.dart';
import 'package:flutter_admin/pages/charts/s_area_age_gender/s_area_age_gender_cartesian.dart';
import 'package:flutter_admin/pages/charts/s_area_age_gender/s_area_age_gender_circular.dart';

class SAreaAgeGenderMain extends StatefulWidget {
  @override
  _SAreaAgeGenderMainState createState() => _SAreaAgeGenderMainState();
}

class _SAreaAgeGenderMainState extends State<SAreaAgeGenderMain> {
  List<SAreaAgeGender> listData;

  bool isPointRadiusMapper = false;
  ChartTypeCircular type = ChartTypeCircular.pie;
  int maxAge = 0;
  List<Tab> tabList;
  List<Widget> tabViewList;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null) {
      return Container();
    }
    var tabBar = TabBar(
      isScrollable: false,
      tabs: tabList,
      indicatorColor: Colors.green,
      labelColor: Colors.black,
    );
    var result = Scaffold(
      body: DefaultTabController(
        length: tabList.length,
        child: Column(
          children: [
            tabBar,
            Expanded(child: TabBarView(children: tabViewList)),
          ],
        ),
      ),
    );
    return result;
  }

  _initTab() {
    tabList = [
      Tab(text: 'circular'),
      Tab(text: 'cartesian'),
    ];
    tabViewList = [
      SAreaAgeGenderCircular(listData),
      SAreaAgeGenderCartesian(listData),
    ];
  }

  _loadData() async {
    var responseBodyApi = await SAreaAgeGenderApi.list();
    listData = List.from(responseBodyApi.data).map((e) => SAreaAgeGender.fromMap(e)).toList();
    maxAge = listData[0].age;
    _initTab();
    setState(() {});
  }
}
