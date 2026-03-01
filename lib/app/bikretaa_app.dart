import 'package:bikretaa/app/app_theme.dart';
import 'package:bikretaa/app/controller/language_controller/language_controller.dart';
import 'package:bikretaa/app/controller/theme_controller/theme_controller.dart';
import 'package:bikretaa/features/user/notification/presentation/services/notification_service.dart';
import 'package:bikretaa/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:bikretaa/features/auth/presentation/screens/sign_up/create_account_screen.dart';
import 'package:bikretaa/features/auth/presentation/screens/signin/signin_screen.dart';
import 'package:bikretaa/features/auth/presentation/screens/splash_screen.dart';
import 'package:bikretaa/features/user/home/calculator/presentaion/screens/calculator.dart';
import 'package:bikretaa/features/user/home/calender/presentation/screens/calender_screen.dart';
import 'package:bikretaa/features/user/home/notes/presentation/screens/notes_screen.dart';
import 'package:bikretaa/features/user/products/presentaion/screens/add_product_screen.dart';
import 'package:bikretaa/features/user/products/presentaion/screens/products_screen.dart';
import 'package:bikretaa/features/user/home/qr_code/presentaion/screens/qr_code_generator.dart';
import 'package:bikretaa/features/user/home/qr_code/presentaion/screens/qr_code_scanner.dart';
import 'package:bikretaa/features/user/home/qr_code/presentaion/screens/qr_product_info_page.dart';
import 'package:bikretaa/features/user/sales/presentation/screens/add_sales_screen.dart';
import 'package:bikretaa/features/user/sales/presentation/screens/due_collection_screen.dart';
import 'package:bikretaa/features/user/settings/setting/presentation/screens/setting_screen.dart';
import 'package:bikretaa/features/admin/bottom_navbar/presentation/screens/admin_main_nav_bar_screen.dart';
import 'package:bikretaa/features/user/bottom_navigation_bar/presentation/screens/user_nav_bar_screen.dart';
import 'package:bikretaa/utils/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../features/user/notification/presentation/screens/notification_screen_user.dart';

class BikretaaApp extends StatelessWidget {
  const BikretaaApp({super.key});

  static GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    final LanguageController languageController = Get.put(LanguageController());

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return GetBuilder<LanguageController>(
          builder: (langController) {
            return GetX<ThemeController>(
              builder: (themeController) {
                return GetMaterialApp(
                  themeMode: themeController.isDarkMode.value
                      ? ThemeMode.dark
                      : ThemeMode.light,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  translations: Languages(),
                  locale: langController.currentLocale,
                  fallbackLocale: const Locale('en', 'US'),
                  navigatorKey: NotificationService.navigatorKey,
                  initialRoute: SplashScreen.name,
                  routes: {
                    SplashScreen.name: (context) => SplashScreen(),
                    SigninScreen.name: (context) => SigninScreen(),
                    CreateAccountScreen.name: (context) =>
                        CreateAccountScreen(),
                    ForgotPasswordScreen.name: (context) =>
                        ForgotPasswordScreen(),
                    UserNavBarScreen.name: (context) => UserNavBarScreen(),
                    AdminMainNavBarScreen.name: (context) =>
                        AdminMainNavBarScreen(),
                    AddProductScreen.name: (context) => AddProductScreen(),
                    ProductsScreen.name: (context) => ProductsScreen(),
                    AddSalesScreen.name: (context) => AddSalesScreen(),
                    SettingScreen.name: (context) => SettingScreen(),
                    DueCollectionScreen.name: (context) =>
                        DueCollectionScreen(),
                    NotificationScreenUser.name: (context) =>
                        NotificationScreenUser(),
                    Calculator.name: (context) => Calculator(),
                    CalendarScreen.name: (context) => CalendarScreen(),
                    QRScannerScreen.name: (context) => QRScannerScreen(),
                    QRGeneratorScreen.name: (context) => QRGeneratorScreen(),
                    NotesScreen.name: (context) => NotesScreen(),
                    ProductInfoPage.name: (context) =>
                        ProductInfoPage(productInfo: ''),
                  },
                  debugShowCheckedModeBanner: false,
                );
              },
            );
          },
        );
      },
    );
  }
}
