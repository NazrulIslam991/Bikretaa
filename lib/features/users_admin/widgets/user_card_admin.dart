import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserCardAdmin extends StatelessWidget {
  final Map<String, dynamic> user;
  const UserCardAdmin({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Colors adapted from the theme
    Color statusColor = user['status'] == "Active"
        ? (theme.colorScheme.secondary) // use secondary for active
        : (theme.colorScheme.error); // use error for inactive/deactivated

    Color cardBackground = theme.cardColor;
    // theme.shadowColor is non-nullable, use directly
    Color shadowColor = theme.shadowColor;

    Color avatarBg =
        theme.colorScheme.primary; // avatar background uses primary
    Color titleColor =
        theme.textTheme.bodyLarge?.color ??
        (isDark ? Colors.white : Colors.black87);
    Color subtitleColor =
        theme.textTheme.bodyMedium?.color ??
        (isDark ? Colors.white70 : Colors.grey[700]!);
    Color metaColor =
        theme.textTheme.bodySmall?.color ??
        (isDark ? Colors.white60 : Colors.grey[600]!);

    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
      shadowColor: shadowColor,
      color: cardBackground,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          color: cardBackground,
        ),
        child: Row(
          children: [
            // Left colored status bar
            Container(
              width: 5.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.r),
                  bottomLeft: Radius.circular(14.r),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            // Avatar
            CircleAvatar(
              radius: 24.r,
              backgroundColor: avatarBg,
              child: Text(
                (user['name'] as String).isNotEmpty ? user['name'][0] : '?',
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            // User details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: titleColor,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    user['shop'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.sp, color: subtitleColor),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    user['email'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11.sp, color: metaColor),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Last login: ${user['lastLogin']}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: metaColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            // Status chip
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: statusColor.withAlpha((0.15 * 255).round()),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                user['status'],
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                ),
              ),
            ),
            SizedBox(width: 6.w),
            Icon(Icons.more_vert, size: 20.sp, color: metaColor),
            SizedBox(width: 6.w),
          ],
        ),
      ),
    );
  }
}
