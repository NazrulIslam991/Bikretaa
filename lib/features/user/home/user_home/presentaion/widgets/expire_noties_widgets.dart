import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class ExpiryNotice extends StatelessWidget {
  final Responsive r;
  final String message;
  final VoidCallback? onViewTap;

  const ExpiryNotice({
    super.key,
    required this.r,
    required this.message,
    this.onViewTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Dynamic colors
    final bgColor = isDark
        ? Colors.red.shade900.withOpacity(0.7)
        : Color(0xffFFE8E8);
    final textColor = isDark ? Colors.white : Colors.red;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: r.height(0.015),
        horizontal: r.width(0.04),
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(r.radiusMedium()),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: textColor, size: r.iconMedium()),
          SizedBox(width: r.width(0.025)),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
                fontSize: r.fontSmall(),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: onViewTap,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              "View →",
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w800,
                fontSize: r.fontSmall(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
