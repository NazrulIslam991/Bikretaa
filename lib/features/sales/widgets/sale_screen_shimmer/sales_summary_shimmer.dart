import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SalesSummaryShimmer extends StatelessWidget {
  const SalesSummaryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resp = Responsive.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade600 : Colors.grey.shade100;

    Widget shimmerCard({EdgeInsets? margin}) => Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(resp.radiusMedium()),
        ),
      ),
    );

    return SizedBox(
      height: resp.height(0.22),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: shimmerCard(
                    margin: EdgeInsets.only(bottom: resp.height(0.01)),
                  ),
                ),
                Expanded(
                  child: shimmerCard(
                    margin: EdgeInsets.only(top: resp.height(0.01)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: resp.width(0.025)),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: shimmerCard(
                    margin: EdgeInsets.only(bottom: resp.height(0.01)),
                  ),
                ),
                Expanded(
                  child: shimmerCard(
                    margin: EdgeInsets.only(top: resp.height(0.01)),
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
