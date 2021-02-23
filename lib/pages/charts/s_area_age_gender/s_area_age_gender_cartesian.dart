import 'package:flutter/material.dart';
import 'package:flutter_admin/models/s_area_age_gender.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SAreaAgeGenderCartesian extends StatefulWidget {
  SAreaAgeGenderCartesian(this.listData);

  final List<SAreaAgeGender> listData;

  @override
  _SAreaAgeGenderCartesianState createState() => _SAreaAgeGenderCartesianState();
}

class _SAreaAgeGenderCartesianState extends State<SAreaAgeGenderCartesian> {
  @override
  Widget build(BuildContext context) {
    return _getDefaultLineChart();
  }

  SfCartesianChart _getDefaultLineChart() {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelIntersectAction: AxisLabelIntersectAction.hide,
      ),
      title: ChartTitle(text: '中国各省人口统计'),
      legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<LineSeries<SAreaAgeGender, String>> _getDefaultLineSeries() {
    return <LineSeries<SAreaAgeGender, String>>[
      LineSeries<SAreaAgeGender, String>(
        dataSource: widget.listData,
        xValueMapper: (SAreaAgeGender sales, _) => sales.area,
        yValueMapper: (SAreaAgeGender sales, _) => sales.age,
        name: '总数',
        markerSettings: MarkerSettings(isVisible: true),
        color: Colors.black,
      ),
      LineSeries<SAreaAgeGender, String>(
        dataSource: widget.listData,
        xValueMapper: (SAreaAgeGender sales, _) => sales.area,
        yValueMapper: (SAreaAgeGender sales, _) => sales.ageG1,
        name: '男性',
        markerSettings: MarkerSettings(isVisible: true),
        color: Colors.blue,
      ),
      LineSeries<SAreaAgeGender, String>(
        dataSource: widget.listData,
        xValueMapper: (SAreaAgeGender sales, _) => sales.area,
        yValueMapper: (SAreaAgeGender sales, _) => sales.ageG2,
        name: '女性',
        markerSettings: MarkerSettings(isVisible: true),
        color: Colors.pink,
      ),
    ];
  }
}
