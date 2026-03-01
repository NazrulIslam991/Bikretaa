import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class KPIWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const KPIWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return Container(
      width: r.width(0.25),
      height: r.height(0.05),
      padding: EdgeInsets.symmetric(
        horizontal: r.width(0.0015),
        vertical: r.height(0.001),
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(r.radiusMedium()),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: r.iconSmall()),
          r.vSpace(0.005),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: r.textStyle(
              fontSize: r.fontSmall(),
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          r.vSpace(0.005),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: r.textStyle(
              fontSize: r.fontSmall(),
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }
}
