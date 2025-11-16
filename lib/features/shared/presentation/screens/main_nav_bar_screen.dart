import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/assets_path/assets_path.dart';
import 'package:bikretaa/features/home/screens/home_screen.dart';
import 'package:bikretaa/features/products/screens/products_screen.dart';
import 'package:bikretaa/features/reports/screens/reports_screen.dart';
import 'package:bikretaa/features/sales/screens/sales_screen.dart';
import 'package:bikretaa/features/setting/screens/setting_screen.dart';
import 'package:bikretaa/features/shared/presentation/widgets/dialog_box/confirm_dialog.dart';
import 'package:flutter/material.dart';
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
    ProductsScreen(),
    SalesScreen(),
    ReportsScreen(),
    SettingScreen(),
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
      // 🔹 Use showConfirmDialog
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
              icon: Icon(Icons.home, size: r.iconMedium()),
              activeIcon: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.20),
                  borderRadius: BorderRadius.circular(r.radiusMedium()),
                ),
                padding: EdgeInsets.all(r.width(0.015)),
                child: Icon(
                  Icons.home,
                  size: r.iconMedium(),
                  color: theme.colorScheme.primary,
                ),
              ),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AssetPaths.product,
                width: r.iconMedium(),
                height: r.iconMedium(),
                color: theme.iconTheme.color,
              ),
              activeIcon: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(r.radiusMedium()),
                ),
                padding: EdgeInsets.all(r.width(0.015)),
                child: Image.asset(
                  AssetPaths.product,
                  width: r.iconMedium(),
                  height: r.iconMedium(),
                  color: theme.colorScheme.primary,
                ),
              ),
              label: 'product'.tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AssetPaths.doller,
                width: r.iconMedium(),
                height: r.iconMedium(),
                color: theme.iconTheme.color,
              ),
              activeIcon: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(r.radiusMedium()),
                ),
                padding: EdgeInsets.all(r.width(0.015)),
                child: Image.asset(
                  AssetPaths.doller,
                  width: r.iconMedium(),
                  height: r.iconMedium(),
                  color: theme.colorScheme.primary,
                ),
              ),
              label: 'sale'.tr,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AssetPaths.report,
                width: r.iconMedium(),
                height: r.iconMedium(),
                color: theme.iconTheme.color,
              ),
              activeIcon: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(r.radiusMedium()),
                ),
                padding: EdgeInsets.all(r.width(0.015)),
                child: Image.asset(
                  AssetPaths.report,
                  width: r.iconMedium(),
                  height: r.iconMedium(),
                  color: theme.colorScheme.primary,
                ),
              ),
              label: 'reports'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: r.iconMedium()),
              activeIcon: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(r.radiusMedium()),
                ),
                padding: EdgeInsets.all(r.width(0.015)),
                child: Icon(
                  Icons.settings,
                  size: r.iconMedium(),
                  color: theme.colorScheme.primary,
                ),
              ),
              label: 'settings'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
