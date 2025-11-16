import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 2,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(r.radiusMedium()),
      ),
      child: Shimmer.fromColors(
        baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
        highlightColor: isDark ? Colors.grey.shade600 : Colors.grey.shade100,
        child: Padding(
          padding: EdgeInsets.all(r.paddingMedium()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholder
              Container(
                height: r.height(0.12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(r.radiusSmall()),
                ),
              ),
              r.vSpace(0.01),

              // Title placeholders
              Container(
                height: r.height(0.02),
                width: double.infinity,
                color: theme.cardColor,
              ),
              r.vSpace(0.005),
              Container(
                height: r.height(0.02),
                width: r.width(0.3),
                color: theme.cardColor,
              ),
              r.vSpace(0.005),
              Container(
                height: r.height(0.02),
                width: r.width(0.2),
                color: theme.cardColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
