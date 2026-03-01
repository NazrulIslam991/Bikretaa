import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../screens/reports_screen.dart';

Widget stockDistributionChart(
  BuildContext context,
  Map<String, int> inventoryStatus,
  Responsive responsive,
  InventoryChartType chartType,
) {
  final colorScheme = Theme.of(context).colorScheme;
  String innerRadius = chartType == InventoryChartType.doughnut ? '65%' : '0%';

  return SizedBox(
    height: responsive.height(0.35),
    child: SfCircularChart(
      margin: EdgeInsets.zero,
      series: <CircularSeries>[
        DoughnutSeries<MapEntry<String, int>, String>(
          dataSource: inventoryStatus.entries.toList(),
          xValueMapper: (data, _) => data.key,
          yValueMapper: (data, _) => data.value.toDouble(),
          pointColorMapper: (data, _) {
            switch (data.key) {
              case "In Stock":
                return Colors.teal.shade400;
              case "Low Stock":
                return Colors.orange.shade400;
              case "Out of Stock":
                return Colors.red.shade400;
              case "Expired":
                return Colors.blueGrey.shade600;
              case "Expire Soon":
                return Colors.amber.shade700;
              default:
                return Colors.blue;
            }
          },
          innerRadius: innerRadius,
          explode: true,
          explodeIndex: 0,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.outside,
            useSeriesColor: true,
            textStyle: responsive.textStyle(
              fontSize: responsive.fontextraSmall(),
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        overflowMode: LegendItemOverflowMode.wrap,
        textStyle: responsive.textStyle(
          fontSize: responsive.fontmediumSmall(),
          color: colorScheme.onSurface,
        ),
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'point.x : point.y Units',
        activationMode: ActivationMode.singleTap,
      ),
    ),
  );
}
