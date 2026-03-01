import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final Responsive r;
  final IconData icon;
  final Color color;
  final String title;
  final String value;

  const SummaryCard({
    super.key,
    required this.r,
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: r.paddingSmall(),
        horizontal: r.paddingMedium(),
      ),
      decoration: BoxDecoration(
        color: theme.cardColor, // adapt to light/dark theme
        borderRadius: BorderRadius.circular(r.radiusMedium()),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // vertical center
        crossAxisAlignment: CrossAxisAlignment.center, // horizontal center
        children: [
          Row(
            mainAxisSize: MainAxisSize.min, // row takes minimal width
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: r.iconMedium()),
              SizedBox(width: r.width(0.03)),
              Text(
                title,
                style: TextStyle(
                  fontSize: r.fontSmall(),
                  fontWeight: FontWeight.w500,
                  color: theme.textTheme.titleSmall?.color, // adapts to theme
                ),
              ),
            ],
          ),
          SizedBox(height: r.height(0.01)),
          Text(
            value,
            style: TextStyle(
              fontSize: r.fontMedium(),
              fontWeight: FontWeight.bold,
              color: theme.textTheme.titleLarge?.color, // adapts to theme
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
