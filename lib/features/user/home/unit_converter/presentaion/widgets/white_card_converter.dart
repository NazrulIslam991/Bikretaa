import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class WhiteCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const WhiteCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);

    return Container(
      padding: padding ?? EdgeInsets.all(r.paddingMedium()),
      decoration: BoxDecoration(
        color: theme.cardColor, // Automatically uses light/dark card color
        borderRadius: BorderRadius.circular(r.radiusMedium()),
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? Colors.white12
              : Colors.black12,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.brightness == Brightness.dark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.06),
            blurRadius: r.width(0.02),
            offset: Offset(0, r.height(0.005)),
          ),
        ],
      ),
      child: child,
    );
  }
}
