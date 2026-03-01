import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class AlertListItem extends StatelessWidget {
  final Map<String, String> alert;

  const AlertListItem({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    Color iconColor = Colors.red.shade700;
    IconData icon = Icons.warning_amber_rounded;
    Color bgColor = Colors.red.shade50;
    Color borderColor = Colors.red.shade200;

    if (alert['type'] == "expiring") {
      iconColor = Colors.orange.shade700;
      icon = Icons.access_time_filled;
      bgColor = Colors.orange.shade50;
      borderColor = Colors.orange.shade200;
    } else if (alert['type'] == "pendingDue") {
      iconColor = Colors.blue.shade700;
      icon = Icons.receipt_long;
      bgColor = Colors.blue.shade50;
      borderColor = Colors.blue.shade200;
    }

    return Container(
      margin: EdgeInsets.only(bottom: responsive.paddingSmall()),
      padding: EdgeInsets.all(responsive.paddingMedium()),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(responsive.radiusSmall()),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: responsive.iconMedium()),
          responsive.hSpace(0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert['title']!,
                  style: responsive.textStyle(
                    fontSize: responsive.fontSmall(),
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
                Text(
                  alert['message']!,
                  style: responsive.textStyle(
                    fontSize: responsive.fontmediumSmall(),
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
