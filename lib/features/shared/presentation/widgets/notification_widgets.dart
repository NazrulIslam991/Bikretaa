import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/notification_users/screens/notification_screen_user.dart';
import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  final int count;
  const NotificationIcon({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications_none, size: r.iconMedium()),
          onPressed: () =>
              Navigator.pushNamed(context, NotificationScreenUser.name),
        ),
      ],
    );
  }
}
