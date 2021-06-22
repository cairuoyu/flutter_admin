/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:flutter/material.dart';
import 'package:flutter_admin/constants/enum.dart';
import 'package:flutter_admin/models/s_area_age_gender.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SAreaAgeGenderCartesian extends StatefulWidget {
  SAreaAgeGenderCartesian(this.listData);

  final List<SAreaAgeGender>? listData;

  @override
  _SAreaAgeGenderCartesianState createState() => _SAreaAgeGenderCartesianState();
}

class _SAreaAgeGenderCartesianState extends State<SAreaAgeGenderCartesian> {
  ChartTypeCartesian? type = ChartTypeCartesian.column;

  @override
  Widget build(BuildContext context) {
    var result = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getSetting(),
        Expanded(child: _getChart()),
      ],
    );
    return result;
  }

  Widget _getSetting() {
    List list = <Widget>[];
    for (var v in ChartTypeCartesian.values) {
      list.add(
        Expanded(
          child: RadioListTile(
            title: Text(v.toString().split('.').last),
            value: v,
            groupValue: type,
            onChanged: (dynamic v) {
              setState(() {
                type = v;
              });
            },
          ),
        ),
      );
    }
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          width: 600,
          child: Row(children: list as List<Widget>),
        ),
        Container(height: 20, child: VerticalDivider(color: Colors.grey)),
      ],
    );
  }

  SfCartesianChart _getChart() {
    var series;
    if (type == ChartTypeCartesian.column) {
      series = _getColumnSeries();
    } else if (type == ChartTypeCartesian.line) {
      series = _getLineSeries();
    } else if (type == ChartTypeCartesian.stackedColumn) {
      series = _getStackedColumnSeries();
    } else {
      series = _getColumnSeries();
    }
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelIntersectAction: AxisLabelIntersectAction.hide,
      ),
      title: ChartTitle(text: '中国各省人口统计'),
      legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      series: series,
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<ColumnSeries<SAreaAgeGender, String>> _getColumnSeries() {
    return <ColumnSeries<SAreaAgeGender, String>>[
      ColumnSeries<SAreaAgeGender, String>(
        dataSource: widget.listData!,
        xValueMapper: (SAreaAgeGender sales, _) => sales.area,
        yValueMapper: (SAreaAgeGender sales, _) => sales.ageG1,
        width: 0.5,
        name: '男性',
      ),
      ColumnSeries<SAreaAgeGender, String>(
        dataSource: widget.listData!,
        xValueMapper: (SAreaAgeGender sales, _) => sales.area,
        yValueMapper: (SAreaAgeGender sales, _) => sales.ageG2,
        width: 0.5,
        name: '女性',
      ),
    ];
  }

  List<StackedColumnSeries<SAreaAgeGender, String>> _getStackedColumnSeries() {
    return <StackedColumnSeries<SAreaAgeGender, String>>[
      StackedColumnSeries<SAreaAgeGender, String>(
        dataSource: widget.listData!,
        xValueMapper: (SAreaAgeGender sales, _) => sales.area,
        yValueMapper: (SAreaAgeGender sales, _) => sales.ageG1,
        width: 0.5,
        name: '男性',
      ),
      StackedColumnSeries<SAreaAgeGender, String>(
        dataSource: widget.listData!,
        xValueMapper: (SAreaAgeGender sales, _) => sales.area,
        yValueMapper: (SAreaAgeGender sales, _) => sales.ageG2,
        width: 0.5,
        name: '女性',
      ),
    ];
  }

  List<LineSeries<SAreaAgeGender, String>> _getLineSeries() {
    return <LineSeries<SAreaAgeGender, String>>[
      LineSeries<SAreaAgeGender, String>(
        dataSource: widget.listData!,
        xValueMapper: (SAreaAgeGender sales, _) => sales.area,
        yValueMapper: (SAreaAgeGender sales, _) => sales.age,
        name: '总数',
        markerSettings: MarkerSettings(isVisible: true),
        color: Colors.black,
      ),
      LineSeries<SAreaAgeGender, String>(
        dataSource: widget.listData!,
        xValueMapper: (SAreaAgeGender sales, _) => sales.area,
        yValueMapper: (SAreaAgeGender sales, _) => sales.ageG1,
        name: '男性',
        markerSettings: MarkerSettings(isVisible: true),
        color: Colors.blue,
      ),
      LineSeries<SAreaAgeGender, String>(
        dataSource: widget.listData!,
        xValueMapper: (SAreaAgeGender sales, _) => sales.area,
        yValueMapper: (SAreaAgeGender sales, _) => sales.ageG2,
        name: '女性',
        markerSettings: MarkerSettings(isVisible: true),
        color: Colors.pink,
      ),
    ];
  }
}
