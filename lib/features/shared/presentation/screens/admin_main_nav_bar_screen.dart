import 'package:bikretaa/features/dashboard_admin/screens/admin_dashboard_screen.dart';
import 'package:bikretaa/features/notification_admin/screens/admin_notification_screen.dart';
import 'package:bikretaa/features/users_admin/screens/admin_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminMainNavBarScreen extends StatefulWidget {
  const AdminMainNavBarScreen({super.key});
  static const name = '/Admin_Nav_bar_screen';

  @override
  State<AdminMainNavBarScreen> createState() => _AdminMainNavBarScreenState();
}

class _AdminMainNavBarScreenState extends State<AdminMainNavBarScreen> {
  final List<Widget> _navigation_screen = [
    AdminDashboardScreen(),
    AdminUserScreen(),
    AdminNotificationScreen(),
  ];
  int _selected_sceen = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: _navigation_screen[_selected_sceen],
      bottomNavigationBar: Container(
        height: 55.h,
        child: NavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          indicatorColor: theme.colorScheme.primary.withOpacity(0.4),
          selectedIndex: _selected_sceen,
          onDestinationSelected: (int index) {
            _selected_sceen = index;
            setState(() {});
          },
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.dashboard_customize,
                color: theme.iconTheme.color,
              ),
              selectedIcon: Icon(
                Icons.dashboard_customize,
                color: theme.colorScheme.primary,
              ),
              label: 'DashBoard',
            ),
            NavigationDestination(
              icon: Icon(Icons.people_alt, color: theme.iconTheme.color),
              selectedIcon: Icon(
                Icons.people_alt,
                color: theme.colorScheme.primary,
              ),
              label: 'Users',
            ),

            NavigationDestination(
              icon: Icon(Icons.notifications_on, color: theme.iconTheme.color),
              selectedIcon: Icon(
                Icons.notifications_on,
                color: theme.colorScheme.primary,
              ),
              label: 'Notification',
            ),
          ],
        ),
      ),
    );
  }
}
