import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import '../generated/l10n.dart';

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

    final desktopSalesData_en = [
      new OrdinalSales('Q1', 5),
      new OrdinalSales('Q2', 25),
      new OrdinalSales('Q3', 100),
      new OrdinalSales('Q4', 75),
    ];

    final tabletSalesData_en = [
      new OrdinalSales('Q1', 25),
      new OrdinalSales('Q2', 50),
      new OrdinalSales('Q3', 10),
      new OrdinalSales('Q4', 20),
    ];

    final mobileSalesData_en = [
      new OrdinalSales('Q1', 10),
      new OrdinalSales('Q2', 15),
      new OrdinalSales('Q3', 50),
      new OrdinalSales('Q4', 45),
    ];

    final otherSalesData_en = [
      new OrdinalSales('Q1', 20),
      new OrdinalSales('Q2', 35),
      new OrdinalSales('Q3', 15),
      new OrdinalSales('Q4', 10),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: Intl.defaultLocale == 'en' ? 'DeskTop' : '待办',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data:
            Intl.defaultLocale == 'en' ? desktopSalesData_en : desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: Intl.defaultLocale == 'en' ? 'Tablet' : '在办',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: Intl.defaultLocale == 'en' ? tabletSalesData_en : tabletSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: Intl.defaultLocale == 'en' ? 'Mobile' : '已办',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: Intl.defaultLocale == 'en' ? mobileSalesData_en : mobileSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: Intl.defaultLocale == 'en' ? 'Other' : '办结',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: Intl.defaultLocale == 'en' ? otherSalesData_en : otherSalesData,
      ),
    ];
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
