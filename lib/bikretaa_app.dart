import 'package:bikretaa/ui/screens/bottom_nav_bar/main_nav_bar_screen.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/products/add_product_screen.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/products/details_product_screen.dart';
import 'package:bikretaa/ui/screens/forgot_password_screen.dart';
import 'package:bikretaa/ui/screens/signin_screen.dart';
import 'package:bikretaa/ui/screens/signup/create_account_by_information.dart';
import 'package:bikretaa/ui/screens/signup/create_account_screen.dart';
import 'package:bikretaa/ui/screens/signup/otp_verification_screen.dart';
import 'package:bikretaa/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class BikretaaApp extends StatelessWidget {
  const BikretaaApp({super.key});

  static GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //navigatorKey: navigator,
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w700,
            color: Colors.blue,
          ),
          titleSmall: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          // input theme
          hintStyle: TextStyle(color: Colors.grey),
          fillColor: Colors.white,

          filled: true,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue, width: 1),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red, width: 1),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.redAccent, width: 2),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromWidth(double.maxFinite),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 12),
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
        CreateAccountByInformation.name: (context) =>
            CreateAccountByInformation(),
        OTPVerificationScreen.name: (context) => OTPVerificationScreen(),
        ForgotPasswordScreen.name: (context) => ForgotPasswordScreen(),
        MainNavBarScreen.name: (context) => MainNavBarScreen(),
        DetailsProductScreen.name: (context) => DetailsProductScreen(),
        AddProductScreen.name: (context) => AddProductScreen(),
        // UpdateProfileScreen.name: (context) => UpdateProfileScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
