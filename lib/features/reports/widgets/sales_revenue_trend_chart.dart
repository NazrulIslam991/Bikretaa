import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../app/responsive.dart';
import '../models/chart_data/chart_data.dart';
import '../screens/reports_screen.dart';

Widget salesRevenueTrendChart(
  BuildContext context,
  List<ChartData> data,
  Responsive responsive,
  CombinedChartType chartType,
) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final bool isDark = theme.brightness == Brightness.dark;

  final Color axisLineColor = isDark ? Colors.white30 : Colors.black26;
  final Color gridLineColor = isDark ? Colors.white10 : Colors.grey.shade300;

  return SizedBox(
    height: responsive.height(0.35),
    child: SfCartesianChart(
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        textStyle: TextStyle(color: colorScheme.onSurface),
      ),
      tooltipBehavior: TooltipBehavior(enable: true, header: ''),

      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        labelStyle: TextStyle(
          fontSize: 10,
          color: colorScheme.onSurface.withValues(alpha: 0.8),
        ),
        axisLine: AxisLine(width: 1.5, color: axisLineColor),
      ),

      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.compact(),
        axisLine: AxisLine(width: 1.5, color: axisLineColor),
        majorTickLines: const MajorTickLines(size: 4),
        majorGridLines: MajorGridLines(width: 0.8, color: gridLineColor),
      ),

      series: <CartesianSeries<ChartData, String>>[
        if (chartType == CombinedChartType.column) ...[
          ColumnSeries<ChartData, String>(
            name: 'Sales',
            dataSource: data,
            xValueMapper: (d, _) => d.x,
            yValueMapper: (d, _) => d.sales,
            color: Colors.blue.shade400,
            borderRadius: BorderRadius.circular(4),
          ),
          ColumnSeries<ChartData, String>(
            name: 'Profit',
            dataSource: data,
            xValueMapper: (d, _) => d.x,
            yValueMapper: (d, _) => d.revenue,
            color: Colors.green.shade400,
            borderRadius: BorderRadius.circular(4),
          ),
        ] else if (chartType == CombinedChartType.line) ...[
          LineSeries<ChartData, String>(
            name: 'Sales',
            dataSource: data,
            xValueMapper: (d, _) => d.x,
            yValueMapper: (d, _) => d.sales,
            color: Colors.blue,
            markerSettings: const MarkerSettings(isVisible: true),
          ),
          LineSeries<ChartData, String>(
            name: 'Profit',
            dataSource: data,
            xValueMapper: (d, _) => d.x,
            yValueMapper: (d, _) => d.revenue,
            color: Colors.green,
            markerSettings: const MarkerSettings(isVisible: true),
          ),
        ] else ...[
          SplineAreaSeries<ChartData, String>(
            name: 'Sales',
            dataSource: data,
            xValueMapper: (d, _) => d.x,
            yValueMapper: (d, _) => d.sales,
            color: Colors.blue.withValues(alpha: 0.2),
            borderColor: Colors.blue,
            borderWidth: 2,
          ),
          SplineAreaSeries<ChartData, String>(
            name: 'Profit',
            dataSource: data,
            xValueMapper: (d, _) => d.x,
            yValueMapper: (d, _) => d.revenue,
            color: Colors.green.withValues(alpha: 0.2),
            borderColor: Colors.green,
            borderWidth: 2,
          ),
        ],
      ],
    ),
  );
}
