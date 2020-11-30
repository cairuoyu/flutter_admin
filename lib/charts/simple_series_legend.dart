import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_admin/generated/l10n.dart';
import 'package:intl/intl.dart';

class SimpleSeriesLegend extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleSeriesLegend(this.seriesList, {this.animate});

  factory SimpleSeriesLegend.withSampleData(BuildContext context) {
    return new SimpleSeriesLegend(
      _createSampleData(context),
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

  static List<charts.Series<OrdinalSales, String>> _createSampleData(BuildContext context) {
    final desktopSalesData = [
      new OrdinalSales('第一季度', 'Q1', 5),
      new OrdinalSales('第二季度', 'Q2', 25),
      new OrdinalSales('第三季度', 'Q3', 100),
      new OrdinalSales('第四季度', 'Q4', 75),
    ];

    final tabletSalesData = [
      new OrdinalSales('第一季度', 'Q1', 25),
      new OrdinalSales('第二季度', 'Q2', 50),
      new OrdinalSales('第三季度', 'Q3', 10),
      new OrdinalSales('第四季度', 'Q4', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('第一季度', 'Q1', 10),
      new OrdinalSales('第二季度', 'Q2', 15),
      new OrdinalSales('第三季度', 'Q3', 50),
      new OrdinalSales('第四季度', 'Q4', 45),
    ];

    final otherSalesData = [
      new OrdinalSales('第一季度', 'Q1', 20),
      new OrdinalSales('第二季度', 'Q2', 35),
      new OrdinalSales('第三季度', 'Q3', 15),
      new OrdinalSales('第四季度', 'Q4', 10),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: S.of(context).dashUpcoming,
        domainFn: (OrdinalSales sales, _) => Intl.defaultLocale == 'en' ? sales.quarterEn : sales.quarter,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: S.of(context).dashInProgress,
        domainFn: (OrdinalSales sales, _) => Intl.defaultLocale == 'en' ? sales.quarterEn : sales.quarter,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tabletSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: S.of(context).dashDone,
        domainFn: (OrdinalSales sales, _) => Intl.defaultLocale == 'en' ? sales.quarterEn : sales.quarter,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: S.of(context).dashFinish,
        domainFn: (OrdinalSales sales, _) => Intl.defaultLocale == 'en' ? sales.quarterEn : sales.quarter,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: otherSalesData,
      ),
    ];
  }
}

class OrdinalSales {
  final String quarter;
  final String quarterEn;
  final int sales;

  OrdinalSales(this.quarter, this.quarterEn, this.sales);
}
