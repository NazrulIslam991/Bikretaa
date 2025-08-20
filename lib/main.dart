import 'package:bikretaa/bikretaa_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'database/cloudinary_database.dart';

final cloudinaryService = CloudinaryService(
  cloudName: 'dqntrxknj',
  uploadPreset: 'Bikretaa',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BikretaaApp());
}
