import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback onTap;
  final bool isPrimary;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isPrimary = true,
    this.color, // optional custom color
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);

    final buttonColor =
        color ?? (isPrimary ? theme.colorScheme.secondary : theme.cardColor);

    final textColor = isPrimary
        ? theme.colorScheme.onSecondary
        : theme.colorScheme.onSurface;

    return Container(
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(r.radiusMedium()),
      ),
      child: TextButton(
        onPressed: onTap,
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(
              fontSize: r.fontXL(),
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
