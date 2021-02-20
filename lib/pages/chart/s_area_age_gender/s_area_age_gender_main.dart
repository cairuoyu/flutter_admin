import 'package:flutter/material.dart';
import 'package:flutter_admin/api/s_area_age_gender.dart';
import 'package:flutter_admin/models/s_area_age_gender.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SAreaAgeGenderMain extends StatefulWidget {
  @override
  _SAreaAgeGenderMainState createState() => _SAreaAgeGenderMainState();
}

class _SAreaAgeGenderMainState extends State<SAreaAgeGenderMain> {
  List<SAreaAgeGender> listData = <SAreaAgeGender>[];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return _getPieChart();
  }

  _loadData() async {
    var responseBodyApi = await SAreaAgeGenderApi.list();
    listData = List.from(responseBodyApi.data).map((e) => SAreaAgeGender.fromMap(e)).toList();
    setState(() {});
  }

  SfCircularChart _getPieChart() {
    return SfCircularChart(
      title: ChartTitle(text: '中国各省人口统计'),
      legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      series: _getPieSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<PieSeries<SAreaAgeGender, String>> _getPieSeries() {
    return <PieSeries<SAreaAgeGender, String>>[
      PieSeries<SAreaAgeGender, String>(
          dataSource: listData,
          xValueMapper: (SAreaAgeGender data, _) => data.area,
          yValueMapper: (SAreaAgeGender data, _) => data.age,
          dataLabelMapper: (SAreaAgeGender data, _) => data.area,
          startAngle: 100,
          endAngle: 100,
          dataLabelSettings: DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside))
    ];
  }
}
