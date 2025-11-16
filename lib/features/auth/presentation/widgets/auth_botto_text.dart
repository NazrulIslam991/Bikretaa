import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthBottomText extends StatelessWidget {
  final String normalText;
  final String actionText;
  final VoidCallback onTap;
  final Color? actionTextColor;
  final Color? normalTextColor;

  const AuthBottomText({
    super.key,
    required this.normalText,
    required this.actionText,
    required this.onTap,
    this.actionTextColor,
    this.normalTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return RichText(
      text: TextSpan(
        text: normalText,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: normalTextColor ?? theme.colorScheme.primary,
          letterSpacing: 0.4,
          fontSize: r.fontSmall(),
        ),
        children: [
          TextSpan(
            text: actionText,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: actionTextColor ?? Colors.blueAccent,
              fontWeight: FontWeight.w600,
              fontSize: r.fontSmall(),
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
