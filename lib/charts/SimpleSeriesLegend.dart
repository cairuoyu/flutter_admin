import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SimpleSeriesLegend extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleSeriesLegend(this.seriesList, {this.animate});

  factory SimpleSeriesLegend.withSampleData() {
    return new SimpleSeriesLegend(
      _createSampleData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [new charts.SeriesLegend()],
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('第一季度', 5),
      new OrdinalSales('第二季度', 25),
      new OrdinalSales('第三季度', 100),
      new OrdinalSales('第四季度', 75),
    ];

    final tabletSalesData = [
      new OrdinalSales('第一季度', 25),
      new OrdinalSales('第二季度', 50),
      new OrdinalSales('第三季度', 10),
      new OrdinalSales('第四季度', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('第一季度', 10),
      new OrdinalSales('第二季度', 15),
      new OrdinalSales('第三季度', 50),
      new OrdinalSales('第四季度', 45),
    ];

    final otherSalesData = [
      new OrdinalSales('第一季度', 20),
      new OrdinalSales('第二季度', 35),
      new OrdinalSales('第三季度', 15),
      new OrdinalSales('第四季度', 10),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: '待办',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: '在办',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tabletSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: '已办',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: '办结',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: otherSalesData,
      ),
    ];
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}