import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/dashboard_admin/screens/admin_dashboard_screen.dart';
import 'package:bikretaa/features/notification_admin/screens/admin_notification_screen.dart';
import 'package:bikretaa/features/shared/presentation/widgets/dialog_box/confirm_dialog.dart';
import 'package:bikretaa/features/users_admin/screens/admin_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminMainNavBarScreen extends StatefulWidget {
  const AdminMainNavBarScreen({super.key});
  static const name = '/Admin_Nav_bar_screen';

  @override
  State<AdminMainNavBarScreen> createState() => _AdminMainNavBarScreenState();
}

class _AdminMainNavBarScreenState extends State<AdminMainNavBarScreen> {
  final List<Widget> _navigationScreen = [
    AdminDashboardScreen(),
    AdminUserScreen(),
    AdminNotificationScreen(),
  ];

  int _selectedScreen = 0;
  final List<int> _navStack = [];

  Future<bool> _onBackPressed() async {
    if (_navStack.isNotEmpty) {
      setState(() {
        _selectedScreen = _navStack.removeLast();
      });
      return false;
    }

    if (_selectedScreen == 0) {
      return await showConfirmDialog(
        context: context,
        title: "exit_app".tr,
        content: "exit_content".tr,
        cancelText: "cancel".tr,
        confirmText: "exit".tr,
        confirmColor: Colors.red,
      );
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: _navigationScreen[_selectedScreen],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedScreen,
          onTap: (index) {
            if (index != _selectedScreen) {
              if (index == 0) {
                _navStack.clear();
              } else {
                _navStack.remove(index);
                _navStack.add(_selectedScreen);
              }
            }
            setState(() => _selectedScreen = index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor:
              theme.bottomNavigationBarTheme.backgroundColor ??
              theme.scaffoldBackgroundColor,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: theme.iconTheme.color,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 8,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_customize, size: r.iconMedium()),
              activeIcon: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.20),
                  borderRadius: BorderRadius.circular(r.radiusMedium()),
                ),
                padding: EdgeInsets.all(r.width(0.015)),
                child: Icon(
                  Icons.dashboard_customize,
                  size: r.iconMedium(),
                  color: theme.colorScheme.primary,
                ),
              ),
              label: 'dashboard'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt, size: r.iconMedium()),
              activeIcon: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(r.radiusMedium()),
                ),
                padding: EdgeInsets.all(r.width(0.015)),
                child: Icon(
                  Icons.people_alt,
                  size: r.iconMedium(),
                  color: theme.colorScheme.primary,
                ),
              ),
              label: 'users'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_on, size: r.iconMedium()),
              activeIcon: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(r.radiusMedium()),
                ),
                padding: EdgeInsets.all(r.width(0.015)),
                child: Icon(
                  Icons.notifications_on,
                  size: r.iconMedium(),
                  color: theme.colorScheme.primary,
                ),
              ),
              label: 'notifications'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
