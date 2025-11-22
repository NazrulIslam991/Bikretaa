import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class ReportItem extends StatelessWidget {
  final Responsive r;
  final String title;
  final VoidCallback? onTap;

  const ReportItem({Key? key, required this.r, required this.title, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Dynamic colors
    final bgColor = isDark ? Colors.grey.shade800 : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final iconColor = isDark ? Colors.white70 : Colors.black54;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: r.height(0.015),
          horizontal: r.width(0.03),
        ),
        margin: EdgeInsets.only(bottom: r.height(0.01)),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(r.radiusMedium()),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: r.fontSmall(), color: textColor),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: r.iconSmall(),
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}
