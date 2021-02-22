import 'package:flutter/material.dart';
import 'package:flutter_admin/api/s_area_age_gender.dart';
import 'package:flutter_admin/constants/enum.dart';
import 'package:flutter_admin/models/s_area_age_gender.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SAreaAgeGenderMain extends StatefulWidget {
  @override
  _SAreaAgeGenderMainState createState() => _SAreaAgeGenderMainState();
}

class _SAreaAgeGenderMainState extends State<SAreaAgeGenderMain> {
  List<SAreaAgeGender> listData = <SAreaAgeGender>[];

  bool isPointRadiusMapper = false;
  ChartTypeCircular type = ChartTypeCircular.pie;
  int maxAge = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    List list = <Widget>[];
    for (var v in ChartTypeCircular.values) {
      list.add(
        Expanded(
          child: RadioListTile(
            title: Text(v.toString().split('.').last),
            value: v,
            groupValue: type,
            onChanged: (v) {
              setState(() {
                type = v;
              });
            },
          ),
        ),
      );
    }
    var result = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 500,
              child: Row(children: list),
            ),
            Container(height: 20, child: VerticalDivider(color: Colors.grey)),
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
          ],
        ),
        Expanded(child: _getCircularChart()),
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

  SfCircularChart _getCircularChart() {
    return SfCircularChart(
      title: ChartTitle(text: '中国各省人口统计'),
      legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      series: type == ChartTypeCircular.pie
          ? _getPieSeries()
          : type == ChartTypeCircular.doughnut
              ? _getDoughnutSeries()
              : _getRadialBarSeries(),

      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<RadialBarSeries<SAreaAgeGender, String>> _getRadialBarSeries() {
    return <RadialBarSeries<SAreaAgeGender, String>>[
      RadialBarSeries<SAreaAgeGender, String>(
        dataSource: listData,
        xValueMapper: (SAreaAgeGender data, _) => data.area,
        yValueMapper: (SAreaAgeGender data, _) => data.age,
        dataLabelMapper: (SAreaAgeGender data, _) => data.area,
        // pointRadiusMapper: _getPointRadiusMapper,
        dataLabelSettings: DataLabelSettings(isVisible: true, labelPosition: ChartDataLabelPosition.outside),
        maximumValue: maxAge.toDouble(),
        innerRadius: '1%',
      )
    ];
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
