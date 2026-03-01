import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class SectionText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double opacity;

  const SectionText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.width(0.03)),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? r.fontMedium(),
          fontWeight: fontWeight ?? FontWeight.normal,
          color: theme.colorScheme.onSurface.withOpacity(opacity),
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
