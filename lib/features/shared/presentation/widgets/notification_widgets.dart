import 'package:bikretaa/features/notification_users/screens/notification_screen_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationIcon extends StatelessWidget {
  final int count;
  const NotificationIcon({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications_none, size: 24.r),
          onPressed: () =>
              Navigator.pushNamed(context, NotificationScreenUser.name),
        ),
        if (count > 0)
          Positioned(
            right: 2.w,
            top: 2.h,
            child: Container(
              padding: EdgeInsets.all(2.r),
              constraints: BoxConstraints(minWidth: 16.w, minHeight: 16.h),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colorScheme.onPrimary.withAlpha(
                    (0.12 * 255).round(),
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
