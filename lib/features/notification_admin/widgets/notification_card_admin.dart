import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCardAdmin extends StatelessWidget {
  final Map<String, String> notification;

  const NotificationCardAdmin({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color iconColor = theme.colorScheme.secondary;
    Color cardBackground = theme.cardColor;
    Color audienceColor =
        theme.textTheme.bodyMedium?.color ??
        (isDark ? Colors.white70 : Colors.grey[800]!);
    Color infoColor =
        theme.textTheme.bodySmall?.color ??
        (isDark ? Colors.white60 : Colors.grey[600]!);
    Color titleColor =
        theme.textTheme.bodyLarge?.color ??
        (isDark ? Colors.white : Colors.black87);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      color: cardBackground,
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.notifications, color: iconColor, size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    notification["title"] ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: titleColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            SizedBox(height: 6.h),

            // Message
            Text(
              notification["message"] ?? "",
              style: TextStyle(
                fontSize: 13.sp,
                color: titleColor.withAlpha((0.9 * 255).round()),
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 8.h),

            // Footer Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Audience label
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: audienceColor.withAlpha((0.12 * 255).round()),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    notification["audience"] ?? "",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: audienceColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Time and recipients
                Text(
                  "${notification["recipients"]} recipients · ${notification["time"]}",
                  style: TextStyle(fontSize: 11.sp, color: infoColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
