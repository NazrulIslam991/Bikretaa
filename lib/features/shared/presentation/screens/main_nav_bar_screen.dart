import 'dart:io';

import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/assets_path/assets_path.dart';
import 'package:bikretaa/features/home/screens/home_screen.dart';
import 'package:bikretaa/features/products/screens/products_screen.dart';
import 'package:bikretaa/features/reports/screens/reports_screen.dart';
import 'package:bikretaa/features/sales/screens/sales_screen.dart';
import 'package:bikretaa/features/setting/screens/setting_screen.dart';
import 'package:bikretaa/features/shared/presentation/widgets/dialog_box/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MainNavBarScreen extends StatefulWidget {
  const MainNavBarScreen({super.key});
  static const name = '/Nav_bar_screen';

  @override
  State<MainNavBarScreen> createState() => _MainNavBarScreenState();
}

class _MainNavBarScreenState extends State<MainNavBarScreen> {
  final List<Widget> _navigationScreen = [
    HomeScreen(),
    SalesScreen(),
    ProductsScreen(),
    ReportsScreen(),
    SettingScreen(),
  ];

  int _selectedScreen = 2;
  final List<int> _navStack = [];

  void _handleBackNavigation(bool didPop) async {
    if (didPop) return;

    if (_navStack.isNotEmpty) {
      setState(() {
        _selectedScreen = _navStack.removeLast();
      });
      return;
    }

    if (_selectedScreen != 0) {
      setState(() => _selectedScreen = 0);
      return;
    }

    if (Platform.isIOS) {
      return;
    }
    final shouldExit = await showConfirmDialog(
      context: context,
      title: "exit_app".tr,
      content: "exit_content".tr,
      cancelText: "cancel".tr,
      confirmText: "exit".tr,
      confirmColor: Colors.red,
    );

    if (shouldExit == true) {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => _handleBackNavigation(didPop),
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
            _buildNavItem(Icons.home, 'home'.tr, 0, theme, r),
            _buildNavItem(
              AssetPaths.doller,
              'sale'.tr,
              1,
              theme,
              r,
              isImage: true,
            ),
            _buildNavItem(
              AssetPaths.product,
              'product'.tr,
              2,
              theme,
              r,
              isImage: true,
            ),
            _buildNavItem(
              AssetPaths.report,
              'reports'.tr,
              3,
              theme,
              r,
              isImage: true,
            ),
            _buildNavItem(Icons.settings, 'settings'.tr, 4, theme, r),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    dynamic iconData,
    String label,
    int index,
    ThemeData theme,
    Responsive r, {
    bool isImage = false,
  }) {
    bool isActive = _selectedScreen == index;

    Widget iconWidget = isImage
        ? Image.asset(
            iconData,
            width: r.iconMedium(),
            height: r.iconMedium(),
            color: theme.iconTheme.color,
          )
        : Icon(iconData, size: r.iconMedium());

    Widget activeIconWidget = Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(r.radiusMedium()),
      ),
      padding: EdgeInsets.all(r.width(0.015)),
      child: isImage
          ? Image.asset(
              iconData,
              width: r.iconMedium(),
              height: r.iconMedium(),
              color: theme.colorScheme.primary,
            )
          : Icon(
              iconData,
              size: r.iconMedium(),
              color: theme.colorScheme.primary,
            ),
    );

    return BottomNavigationBarItem(
      icon: iconWidget,
      activeIcon: activeIconWidget,
      label: label,
    );
  }
}
