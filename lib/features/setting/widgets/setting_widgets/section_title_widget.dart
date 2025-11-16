import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;
  const SectionTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return Padding(
      padding: EdgeInsets.only(
        right: r.width(0.01),
        left: r.width(0.01),
        top: r.height(0.02),
        bottom: r.height(0.015),
      ),
      child: Text(
        title.toUpperCase(),
        style: r.textStyle(
          fontSize: r.fontSmall(),
          fontWeight: FontWeight.normal,
          color: theme.colorScheme.primary,
          height: 1.2,
        ),
      ),
    );
  }
}
