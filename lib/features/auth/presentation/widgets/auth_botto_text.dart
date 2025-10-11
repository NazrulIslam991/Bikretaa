import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return RichText(
      text: TextSpan(
        text: normalText,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: normalTextColor ?? theme.colorScheme.primary,
          letterSpacing: 0.4,
          fontSize: 10.h,
        ),
        children: [
          TextSpan(
            text: actionText,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: actionTextColor ?? Colors.blueAccent,
              fontWeight: FontWeight.w700,
              fontSize: 10.h,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
