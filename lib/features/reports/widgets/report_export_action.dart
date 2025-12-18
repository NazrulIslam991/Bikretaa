import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show ElevatedButton, Colors, OutlinedButton;

import '../../../app/responsive.dart' show Responsive;

class ExportButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final bool isFilled;
  final VoidCallback onPressed;

  const ExportButton({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.isFilled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final textStyle = responsive.textStyle(
      fontSize: responsive.fontSmall(),
      fontWeight: FontWeight.bold,
    );

    if (isFilled) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: responsive.iconMedium()),
        label: Text(text, overflow: TextOverflow.ellipsis, style: textStyle),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: responsive.paddingSmall(),
            vertical: responsive.height(0.015),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(responsive.radiusSmall()),
          ),
          elevation: 4,
        ),
      );
    } else {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: responsive.iconMedium()),
        label: Text(text, overflow: TextOverflow.ellipsis, style: textStyle),
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color, width: 1.5),
          padding: EdgeInsets.symmetric(
            horizontal: responsive.paddingSmall(),
            vertical: responsive.height(0.015),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(responsive.radiusSmall()),
          ),
        ),
      );
    }
  }
}
