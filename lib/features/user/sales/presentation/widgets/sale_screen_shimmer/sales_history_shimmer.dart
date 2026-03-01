import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SalesHistoryShimmer extends StatelessWidget {
  const SalesHistoryShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resp = Responsive.of(context); // Use Responsive
    final isDark = theme.brightness == Brightness.dark;

    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade600 : Colors.grey.shade100;

    return ListView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: resp.height(0.012),
          ), // adaptive spacing
          child: Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              padding: EdgeInsets.all(resp.width(0.02)), // adaptive padding
              height: resp.height(0.12), // adaptive height
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(
                  resp.radiusMedium(),
                ), // adaptive radius
              ),
            ),
          ),
        );
      },
    );
  }
}
