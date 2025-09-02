import 'package:bikretaa/app/bikretaa_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/theme_controller.dart';
import 'database/product/cloudinary_database.dart';

final cloudinaryService = CloudinaryService(
  cloudName: 'dqntrxknj',
  uploadPreset: 'Bikretaa',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ThemeController());
  runApp(BikretaaApp());
}
