import 'package:bikretaa/app/bikretaa_app.dart';
import 'package:bikretaa/utils/app_version_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/theme_controller.dart';
import 'features/products/database/cloudinary_database.dart';

final cloudinaryService = CloudinaryService(
  cloudName: 'dqntrxknj',
  uploadPreset: 'Bikretaa',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ThemeController());
  AppVersionServces.getCurrentAppVersion();
  runApp(BikretaaApp());
}
