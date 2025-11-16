import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class ActivitiesCard extends StatelessWidget {
  final List<Map<String, dynamic>> activities;
  const ActivitiesCard({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(r.paddingMedium()),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(r.radiusMedium()), //
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: activities.length,
        separatorBuilder: (_, __) =>
            Divider(color: theme.dividerColor, height: r.height(0.02)),
        itemBuilder: (context, index) {
          final a = activities[index];
          final Color aColor = a['color'] as Color;
          return ListTile(
            dense: true,
            minLeadingWidth: r.width(0.07),
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: r.iconMedium(),
              backgroundColor: aColor.withAlpha(40),
              child: Icon(
                a['icon'] as IconData,
                color: aColor,
                size: r.iconMedium(),
              ),
            ),
            title: Text(
              a['text'] as String,
              style: r.textStyle(
                fontSize: r.fontMedium(),
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
            subtitle: Text(
              a['time'] as String,
              style: r.textStyle(
                fontSize: r.fontSmall(),
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
          );
        },
      ),
    );
  }
}
