import 'package:bikretaa/ui/screens/bottom_nav_bar/navbar_screens/home_screen.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/navbar_screens/products_screen.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/navbar_screens/reports_screen.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/navbar_screens/sales_screen.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/navbar_screens/setting_screen.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      body: _navigation_screen[_selected_sceen],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selected_sceen,
        onDestinationSelected: (int index) {
          _selected_sceen = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
            icon: Image.asset(
              'assets/images/product.png',
              width: 24,
              height: 24,
            ),
            label: 'Prodcts',
          ),
          NavigationDestination(
            icon: Image.asset(
              'assets/images/doller.png',
              width: 24,
              height: 24,
            ),
            label: 'Sales',
          ),
          NavigationDestination(
            icon: Image.asset(
              'assets/images/report.png',
              width: 24,
              height: 24,
            ),
            label: 'Reports',
          ),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}
