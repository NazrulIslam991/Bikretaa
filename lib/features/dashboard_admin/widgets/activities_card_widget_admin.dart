import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivitiesCard extends StatelessWidget {
  final List<Map<String, dynamic>> activities;
  const ActivitiesCard({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: activities.length,
        separatorBuilder: (_, __) => Divider(color: theme.dividerColor),
        itemBuilder: (context, index) {
          final a = activities[index];
          final Color aColor = a['color'] as Color;
          return ListTile(
            dense: true,
            minLeadingWidth: 28.w,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 16.r,
              backgroundColor: aColor.withAlpha(40),
              child: Icon(a['icon'] as IconData, color: aColor, size: 16.sp),
            ),
            title: Text(
              a['text'] as String,
              style: TextStyle(
                fontSize: 13.sp,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
            subtitle: Text(
              a['time'] as String,
              style: TextStyle(
                fontSize: 11.sp,
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
          );
        },
      ),
    );
  }
}
