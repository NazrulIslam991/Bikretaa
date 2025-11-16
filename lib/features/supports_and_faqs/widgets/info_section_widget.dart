import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget child;

  const InfoSection({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: r.iconMedium()),
            SizedBox(width: r.width(0.02)),
            Text(
              title,
              style: TextStyle(
                fontSize: r.fontMedium(),
                fontWeight: FontWeight.w500,
                color: iconColor,
              ),
            ),
          ],
        ),
        SizedBox(height: r.height(0.015)),
        child,
      ],
    );
  }
}
