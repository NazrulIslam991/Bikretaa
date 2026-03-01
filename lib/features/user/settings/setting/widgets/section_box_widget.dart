import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class SectionBoxWidget extends StatelessWidget {
  final List<Widget> children;
  const SectionBoxWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(r.radiusMedium()),
        border: Border.all(color: isDark ? Colors.white30 : Colors.grey.shade300),
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              Divider(
                height: r.height(0.002),
                thickness: r.height(0.001),
                indent: r.width(0.06),
                  color: isDark ? Colors.white30 : Colors.grey.shade300
              ),
          ],
        ],
      ),
    );
  }
}
