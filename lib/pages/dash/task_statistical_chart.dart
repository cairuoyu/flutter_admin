/// @author: cairuoyu
/// @homepage: http://cairuoyu.com
/// @github: https://github.com/cairuoyu/flutter_admin
/// @date: 2021/6/21
/// @version: 1.0
/// @description:

import 'package:flutter/material.dart';
import 'package:flutter_admin/data/data_dashboard.dart';
import 'package:flutter_admin/generated/l10n.dart';
import 'package:flutter_admin/models/task_statistical_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TaskStatisticalChart extends StatefulWidget {
  @override
  _TaskStatisticalChartState createState() => _TaskStatisticalChartState();
}

class _TaskStatisticalChartState extends State<TaskStatisticalChart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: true),
      primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0), labelPlacement: LabelPlacement.onTicks),
      series: _getSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<SplineSeries<TaskStatisticalModel, String>> _getSeries() {
    return <SplineSeries<TaskStatisticalModel, String>>[
      SplineSeries<TaskStatisticalModel, String>(
        name: S.of(context).dashUpcoming,
        dataSource: taskStatisticalList,
        xValueMapper: (TaskStatisticalModel sales, _) => sales.timeName,
        yValueMapper: (TaskStatisticalModel sales, _) => sales.upcomingCount,
        markerSettings: MarkerSettings(isVisible: true),
      ),
      SplineSeries<TaskStatisticalModel, String>(
        name: S.of(context).dashInProgress,
        dataSource: taskStatisticalList,
        markerSettings: MarkerSettings(isVisible: true),
        xValueMapper: (TaskStatisticalModel sales, _) => sales.timeName,
        yValueMapper: (TaskStatisticalModel sales, _) => sales.inProgressCount,
      ),
      // SplineSeries<TaskStatisticalModel, String>(
      //   name: S.of(context).dashDone,
      //   dataSource: taskStatisticalList,
      //   xValueMapper: (TaskStatisticalModel sales, _) => sales.timeName,
      //   yValueMapper: (TaskStatisticalModel sales, _) => sales.doneCount,
      //   markerSettings: MarkerSettings(isVisible: true),
      // ),
      // SplineSeries<TaskStatisticalModel, String>(
      //   name: S.of(context).dashFinish,
      //   dataSource: taskStatisticalList,
      //   markerSettings: MarkerSettings(isVisible: true),
      //   xValueMapper: (TaskStatisticalModel sales, _) => sales.timeName,
      //   yValueMapper: (TaskStatisticalModel sales, _) => sales.finishCount,
      // ),
    ];
  }
}
