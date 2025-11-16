import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool isFullWidth;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return Container(
      width: isFullWidth ? double.infinity : r.width(0.45),
      padding: EdgeInsets.all(r.paddingMedium()),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(r.radiusMedium()),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(r.paddingSmall()),
                decoration: BoxDecoration(
                  color: color.withAlpha((0.12 * 255).round()),
                  borderRadius: BorderRadius.circular(r.radiusSmall()),
                ),
                child: Icon(icon, color: color, size: r.iconMedium()),
              ),
              r.hSpace(0.02),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: r.textStyle(
                        fontSize: r.fontMedium(),
                        fontWeight: FontWeight.w700,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    r.vSpace(0.005),
                    Text(
                      subtitle,
                      style: r.textStyle(
                        fontSize: r.fontSmall(),
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          r.vSpace(0.01), // vertical spacing
          LinearProgressIndicator(
            value: 0.6,
            color: color,
            backgroundColor: theme.dividerColor.withAlpha((0.08 * 255).round()),
            minHeight: r.height(0.008), // responsive height
          ),
        ],
      ),
    );
  }
}
