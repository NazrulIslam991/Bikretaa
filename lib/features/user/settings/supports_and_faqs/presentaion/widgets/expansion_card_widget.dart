import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class ExpansionCard extends StatelessWidget {
  final String title;
  final String? description;
  final Color? titleColor;

  const ExpansionCard({
    super.key,
    required this.title,
    this.description,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.only(bottom: r.height(0.01)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(r.radiusMedium()),
      ),
      color: theme.cardColor,
      elevation: 2,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(
          horizontal: r.paddingMedium(),
          vertical: r.height(0.005),
        ),
        childrenPadding: EdgeInsets.symmetric(
          horizontal: r.paddingMedium(),
          vertical: r.height(0.01),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: titleColor ?? theme.colorScheme.primary,
            fontSize: r.fontMedium(),
          ),
        ),
        children: description != null
            ? [
                Text(
                  description!,
                  style: TextStyle(
                    fontSize: r.fontSmall(),
                    fontStyle: FontStyle.italic,
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ]
            : [],
      ),
    );
  }
}
