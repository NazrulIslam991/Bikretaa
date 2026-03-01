import 'dart:io';
import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/assets_path/assets_path.dart';
import 'package:bikretaa/features/user/home/user_home/presentaion/screens/home_screen.dart';
import 'package:bikretaa/features/user/products/presentaion/screens/products_screen.dart';
import 'package:bikretaa/features/user/reports/presentation/screens/reports_screen.dart';
import 'package:bikretaa/features/user/sales/presentation/screens/sales_screen.dart';
import 'package:bikretaa/features/user/settings/setting/presentation/screens/setting_screen.dart';
import 'package:bikretaa/features/shared/presentation/widgets/dialog_box/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserNavBarScreen extends StatefulWidget {
  const UserNavBarScreen({super.key});
  static const name = '/Nav_bar_screen';

  @override
  State<UserNavBarScreen> createState() => _UserNavBarScreenState();
}

class _UserNavBarScreenState extends State<UserNavBarScreen> {
  int _currentIndex = 2;

  final List<Widget> _screens = const [
    HomeScreen(),
    SalesScreen(),
    ProductsScreen(),
    ReportsScreen(),
    SettingScreen(),
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
        ? Colors.grey.shade100
        : Colors.grey.shade900;

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

        ///  CUSTOM FLOATING BOTTOM NAVBAR
        bottomNavigationBar: SizedBox(
          height: r.height(0.12),
          child: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              /// Background Bar
              Container(
                height: r.height(0.08),
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
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
                    _navItem(0, Icons.home,  Colors.blue.shade200, unselectedColor),
                    _navItem(1, AssetPaths.doller,
                        Colors.blue.shade200, unselectedColor,
                        isImage: true),
                    const SizedBox(width: 50), 
                    _navItem(3, AssetPaths.report,
                        Colors.blue.shade200, unselectedColor,
                        isImage: true),
                    _navItem(4, Icons.settings,  Colors.blue.shade200, unselectedColor),
                  ],
                ),
              ),

              /// Floating Center Button
              Positioned(
                top: -13,
                child: GestureDetector(
                  onTap: () => setState(() => _currentIndex = 2),
                  child: Container(
                    height: r.height(0.065),
                    //width: r.width(0.07),
                    decoration: BoxDecoration(
                      color: _currentIndex == 2
                          ?  Colors.blue.shade200
                          : Colors.grey.shade200,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      AssetPaths.product,
                      color: _currentIndex == 2 ? Colors.black : Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// NAV ITEM
  Widget _navItem(int index, dynamic icon, Color selectedColor, Color unselectedColor,
      {bool isImage = false}) {
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
        child: isImage
            ? Image.asset(
          icon,
          color: isSelected ? Colors.black : unselectedColor,
        )
            : Icon(
          icon,
          color: isSelected ? Colors.black : unselectedColor,
        ),
      ),
    );
  }
}