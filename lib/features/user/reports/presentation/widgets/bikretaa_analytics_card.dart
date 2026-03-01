import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class BikretaaAnalyticsCard extends StatelessWidget {
  final String title;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Widget? headerChild;
  final Color? cardColor;
  final bool isDark;

  const BikretaaAnalyticsCard({
    super.key,
    required this.title,
    required this.child,
    this.padding,
    this.headerChild,
    this.cardColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final effectivePadding =
        padding ?? EdgeInsets.all(responsive.paddingMedium());

    final Color effectiveBorderColor = isDark
        ? Colors.white.withValues(alpha: 0.5)
        : Colors.grey.shade200;

    return Card(
      color: cardColor ?? theme.cardColor,
      elevation: isDark ? 0 : 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsive.radiusMedium()),
        side: BorderSide(color: effectiveBorderColor, width: isDark ? 1.5 : 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: effectivePadding.vertical / 2 + responsive.paddingSmall(),
              left: effectivePadding.horizontal / 2 + responsive.paddingSmall(),
              right:
                  effectivePadding.horizontal / 2 + responsive.paddingSmall(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: responsive.textStyle(
                    fontSize: responsive.fontLarge(),
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                if (headerChild != null)
                  IconTheme(
                    data: IconThemeData(color: colorScheme.onSurface),
                    child: headerChild!,
                  ),
              ],
            ),
          ),
          responsive.vSpace(0.01),
          Divider(
            height: responsive.height(0.03),
            thickness: 0.5,
            color: colorScheme.primary,
          ),
          Padding(padding: effectivePadding, child: child),
        ],
      ),
    );
  }
}
