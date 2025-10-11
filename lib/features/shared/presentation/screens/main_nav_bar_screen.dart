import 'package:bikretaa/assets_path/assets_path.dart';
import 'package:bikretaa/features/home/screens/home_screen.dart';
import 'package:bikretaa/features/products/screens/products_screen.dart';
import 'package:bikretaa/features/reports/screens/reports_screen.dart';
import 'package:bikretaa/features/sales/screens/sales_screen.dart';
import 'package:bikretaa/features/setting/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainNavBarScreen extends StatefulWidget {
  const MainNavBarScreen({super.key});
  static const name = '/Nav_bar_screen';

  @override
  State<MainNavBarScreen> createState() => _MainNavBarScreenState();
}

class _MainNavBarScreenState extends State<MainNavBarScreen> {
  final List<Widget> _navigation_screen = [
    HomeScreen(),
    ProductsScreen(),
    SalesScreen(),
    ReportsScreen(),
    SettingScreen(),
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
              icon: Icon(Icons.home, color: theme.iconTheme.color),
              selectedIcon: Icon(Icons.home, color: theme.colorScheme.primary),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Image.asset(
                AssetPaths.product,
                width: 20.h,
                height: 20.h,
                color: theme.iconTheme.color,
              ),
              selectedIcon: Image.asset(
                AssetPaths.product,
                width: 20.h,
                height: 20.h,
                color: theme.colorScheme.primary,
              ),
              label: 'Products',
            ),

            NavigationDestination(
              icon: Image.asset(
                AssetPaths.doller,
                width: 20.h,
                height: 20.h,
                color: theme.iconTheme.color,
              ),
              selectedIcon: Image.asset(
                AssetPaths.doller,
                width: 20.h,
                height: 20.h,
                color: theme.colorScheme.primary,
              ),
              label: 'Sales',
            ),

            NavigationDestination(
              icon: Image.asset(
                AssetPaths.report,
                width: 20.h,
                height: 20.h,
                color: theme.iconTheme.color,
              ),
              selectedIcon: Image.asset(
                AssetPaths.report,
                width: 20.h,
                height: 20.h,
                color: theme.colorScheme.primary,
              ),
              label: 'Reports',
            ),

            NavigationDestination(
              icon: Icon(Icons.settings, color: theme.iconTheme.color),
              selectedIcon: Icon(
                Icons.settings,
                color: theme.colorScheme.primary,
              ),
              label: 'Setting',
            ),
          ],
        ),
      ),
    );
  }
}
