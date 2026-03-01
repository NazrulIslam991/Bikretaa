import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return Text(
      title,
      style: r.textStyle(
        fontSize: r.fontMedium(),
        fontWeight: FontWeight.w700,
        color: theme.textTheme.titleLarge?.color,
      ),
    );
  }
}
