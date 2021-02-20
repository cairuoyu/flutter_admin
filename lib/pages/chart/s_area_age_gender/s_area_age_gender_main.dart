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

  bool isDoughnut = false;
  bool isPointRadiusMapper = false;
  int maxAge = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    var result = Column(
      children: [
        Wrap(
          children: [
            SizedBox(
              width: 260,
              child: SwitchListTile(
                value: isPointRadiusMapper,
                title: Text('pointRadiusMapper'),
                onChanged: (v) {
                  isPointRadiusMapper = v;
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              width: 260,
              child: SwitchListTile(
                value: isDoughnut,
                title: Text('Doughnut'),
                onChanged: (v) {
                  isDoughnut = v;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Expanded(child: _getPieChart()),
      ],
    );
    return result;
  }

  _loadData() async {
    var responseBodyApi = await SAreaAgeGenderApi.list();
    listData = List.from(responseBodyApi.data).map((e) => SAreaAgeGender.fromMap(e)).toList();
    maxAge = listData[0].age;
    setState(() {});
  }

  SfCircularChart _getPieChart() {
    return SfCircularChart(
      title: ChartTitle(text: '中国各省人口统计'),
      legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      series: this.isDoughnut ? _getDoughnutSeries() : _getPieSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<DoughnutSeries<SAreaAgeGender, String>> _getDoughnutSeries() {
    return <DoughnutSeries<SAreaAgeGender, String>>[
      DoughnutSeries<SAreaAgeGender, String>(
          explode: true,
          dataSource: listData,
          xValueMapper: (SAreaAgeGender data, _) => data.area,
          yValueMapper: (SAreaAgeGender data, _) => data.age,
          dataLabelMapper: (SAreaAgeGender data, _) => data.area,
          startAngle: 100,
          endAngle: 100,
          pointRadiusMapper: _getPointRadiusMapper,
          dataLabelSettings: DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside))
    ];
  }

  List<PieSeries<SAreaAgeGender, String>> _getPieSeries() {
    return <PieSeries<SAreaAgeGender, String>>[
      PieSeries<SAreaAgeGender, String>(
          explode: true,
          dataSource: listData,
          xValueMapper: (SAreaAgeGender data, _) => data.area,
          yValueMapper: (SAreaAgeGender data, _) => data.age,
          dataLabelMapper: (SAreaAgeGender data, _) => data.area,
          startAngle: 100,
          endAngle: 100,
          pointRadiusMapper: _getPointRadiusMapper,
          dataLabelSettings: DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside))
    ];
  }

  String _getPointRadiusMapper(SAreaAgeGender data, int index) {
    return this.isPointRadiusMapper ? (data.age / maxAge * 100).toString() + '%' : '100%';
  }
}
