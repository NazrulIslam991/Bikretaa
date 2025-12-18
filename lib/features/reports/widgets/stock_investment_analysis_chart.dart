import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/chart_data/chart_data.dart';
import '../screens/reports_screen.dart';

Widget stockInvestmentAnalysisChart(
  BuildContext context,
  List<ChartData> data,
  Responsive responsive,
  ExpenseChartType chartType,
) {
  return SizedBox(
    height: responsive.height(0.3),
    child: SfCartesianChart(
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.compact(),
        majorGridLines: MajorGridLines(
          width: 0.5,
          dashArray: const [5, 5],
          color: Theme.of(context).dividerColor,
        ),
      ),
      tooltipBehavior: TooltipBehavior(enable: true, header: 'Cost'),
      series: <CartesianSeries<ChartData, String>>[
        if (chartType == ExpenseChartType.column)
          ColumnSeries<ChartData, String>(
            name: 'Stock Value',
            dataSource: data,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.sales,
            color: Colors.purple.shade400,
            borderRadius: BorderRadius.circular(4),
          )
        else
          LineSeries<ChartData, String>(
            name: 'Stock Value',
            dataSource: data,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.sales,
            color: Colors.purple,
            markerSettings: const MarkerSettings(isVisible: true),
          ),
      ],
    ),
  );
}
