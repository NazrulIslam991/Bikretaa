import 'package:bikretaa/app/bikretaa_app.dart';
import 'package:bikretaa/app/controller/expense_report_controller.dart';
import 'package:bikretaa/utils/app_version_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/controller/customer_controller/customer_controller.dart';
import 'app/controller/product_controller/product_controller.dart';
import 'app/controller/sales_controller/sales_controller.dart';
import 'app/controller/sales_report_controller.dart';
import 'app/controller/theme_controller/theme_controller.dart';
import 'app/string.dart';
import 'features/products/database/cloudinary_database.dart';

final cloudinaryService = CloudinaryService(
  cloudName: AppConstants.cloudName,
  uploadPreset: AppConstants.uploadPreset,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ThemeController());

  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    Get.put(ProductController(), permanent: true);
    Get.put(CustomerController(), permanent: true);
    Get.put(SalesController(), permanent: true);
    Get.put(SalesReportController());
    Get.put(ExpenseReportController());
  }
  AppVersionServces.getCurrentAppVersion();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(BikretaaApp());
  // runApp(
  //   DevicePreview(enabled: !kReleaseMode, builder: (context) => BikretaaApp()),
  // );
}
