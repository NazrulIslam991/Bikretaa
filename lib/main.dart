import 'package:bikretaa/app/bikretaa_app.dart';
import 'package:bikretaa/app/controller/customer_controller/customer_controller.dart';
import 'package:bikretaa/app/controller/product_controller/product_controller.dart';
import 'package:bikretaa/utils/app_version_services.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/controller/sales_controller/sales_controller.dart'
    show SalesController;
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
  AppVersionServces.getCurrentAppVersion();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(SalesController());
  Get.put(ProductController());
  Get.put(CustomerController());

  //runApp(BikretaaApp());
  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => BikretaaApp()),
  );
}
