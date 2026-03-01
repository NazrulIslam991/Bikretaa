import 'dart:io';
import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/admin/deshboard/presentation/screens/admin_dashboard_screen.dart';
import 'package:bikretaa/features/admin/notification/presentaion/screens/admin_notification_screen.dart';
import 'package:bikretaa/features/admin/user_list/presentation/screens/user_list_screen.dart';
import 'package:bikretaa/features/shared/presentation/widgets/dialog_box/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AdminMainNavBarScreen extends StatefulWidget {
  const AdminMainNavBarScreen({super.key});
  static const name = '/Admin_Nav_bar_screen';

  @override
  State<AdminMainNavBarScreen> createState() => _AdminMainNavBarScreenState();
}

class _AdminMainNavBarScreenState extends State<AdminMainNavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    AdminDashboardScreen(),
    UserListScreen(),
    AdminNotificationScreen(),
  ];

  Future<void> _handleBack() async {
    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      return;
    }

    if (Platform.isIOS) return;

    final shouldExit = await showConfirmDialog(
      context: context,
      title: "Exit App",
      content: "Do you want to exit the app?",
      cancelText: "Cancel",
      confirmText: "Exit",
      confirmColor: Colors.red,
    );

    if (shouldExit == true) {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);

    final Color backgroundColor = theme.brightness == Brightness.light
        ? Colors.grey.shade300
        : Colors.grey.shade800;

    final Color unselectedColor = theme.brightness == Brightness.light
        ? Colors.black87
        : Colors.white70;

    return WillPopScope(
      onWillPop: () async {
        await _handleBack();
        return false;
      },
      child: Scaffold(
        extendBody: true,
        body: _screens[_currentIndex],

        /// CUSTOM BOTTOM NAVBAR (all in one row)
        bottomNavigationBar: Container(
          height: r.height(0.08),
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _navItem(0, Icons.dashboard_customize, Colors.blue.shade200, unselectedColor),
              _navItem(1, Icons.people_alt, Colors.blue.shade200, unselectedColor),
              _navItem(2, Icons.notifications_on, Colors.blue.shade200, unselectedColor),
            ],
          ),
        ),
      ),
    );
  }

  /// NAV ITEM
  Widget _navItem(
      int index, IconData icon, Color selectedColor, Color unselectedColor) {
    bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        height: Responsive.of(context).height(0.06),
        width: 55,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Theme.of(context).highlightColor,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          color: isSelected ? Colors.black : unselectedColor,
        ),
      ),
    );
  }
}