import 'package:bikretaa/ui/screens/bottom_nav_bar/main_nav_bar_screen.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/navbar_screens/products_screen.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/products/add_product_screen.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/sales_product/add_sales_screen.dart';
import 'package:bikretaa/ui/screens/forgot_password_screen.dart';
import 'package:bikretaa/ui/screens/signin_screen.dart';
import 'package:bikretaa/ui/screens/signup/create_account_screen.dart';
import 'package:bikretaa/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BikretaaApp extends StatelessWidget {
  const BikretaaApp({super.key});

  static GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          // navigatorKey: navigator,
          theme: ThemeData(
            textTheme: TextTheme(
              titleLarge: TextStyle(
                fontSize: 33.sp,
                fontWeight: FontWeight.w700,
                color: Colors.blue,
              ),
              titleSmall: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: const TextStyle(color: Colors.grey),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.blueAccent,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.redAccent, width: 2),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromWidth(double.maxFinite),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.green),
            ),
          ),
          initialRoute: '/',
          routes: {
            SplashScreen.name: (context) => SplashScreen(),
            SigninScreen.name: (context) => SigninScreen(),
            CreateAccountScreen.name: (context) => CreateAccountScreen(),
            //CreateAccountByInformation.name: (context) => CreateAccountByInformation(),
            //OTPVerificationScreen.name: (context) => OTPVerificationScreen(),
            ForgotPasswordScreen.name: (context) => ForgotPasswordScreen(),
            MainNavBarScreen.name: (context) => MainNavBarScreen(),
            //DetailsProductScreen.name: (context) => DetailsProductScreen(),
            AddProductScreen.name: (context) => AddProductScreen(),
            ProductsScreen.name: (context) => ProductsScreen(),
            AddSalesScreen.name: (context) => AddSalesScreen(),
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
