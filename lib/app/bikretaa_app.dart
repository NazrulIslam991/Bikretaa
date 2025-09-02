import 'package:bikretaa/app/app_theme.dart';
import 'package:bikretaa/app/theme_controller.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/main_nav_bar_screen.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/navbar_screens/products_screen.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/navbar_screens/setting_screen.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/products/add_product_screen.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/sales_product/add_sales_screen.dart';
import 'package:bikretaa/ui/screens/forgot_password_screen.dart';
import 'package:bikretaa/ui/screens/signin_and_signup/sign_up/create_account_screen.dart';
import 'package:bikretaa/ui/screens/signin_and_signup/signin/signin_screen.dart';
import 'package:bikretaa/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BikretaaApp extends StatelessWidget {
  const BikretaaApp({super.key});

  static GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    //final ThemeController themeController = Get.put(ThemeController());

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return GetX<ThemeController>(
          builder: (controller) {
            return GetMaterialApp(
              themeMode: controller.isDarkMode.value
                  ? ThemeMode.dark
                  : ThemeMode.light,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              initialRoute: '/',
              routes: {
                SplashScreen.name: (context) => SplashScreen(),
                SigninScreen.name: (context) => SigninScreen(),
                CreateAccountScreen.name: (context) => CreateAccountScreen(),
                ForgotPasswordScreen.name: (context) => ForgotPasswordScreen(),
                MainNavBarScreen.name: (context) => MainNavBarScreen(),
                AddProductScreen.name: (context) => AddProductScreen(),
                ProductsScreen.name: (context) => ProductsScreen(),
                AddSalesScreen.name: (context) => AddSalesScreen(),
                SettingScreen.name: (context) => SettingScreen(),
              },
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
    );
  }
}
