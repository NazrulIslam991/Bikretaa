import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final double opacity;

  const SectionText({
    super.key,
    required this.text,
    required this.fontSize,
    this.fontWeight,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.0.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: theme.colorScheme.onSurface.withOpacity(opacity),
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
