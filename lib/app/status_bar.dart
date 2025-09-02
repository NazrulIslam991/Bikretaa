import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarColor {
  // Light Mode
  static SystemUiOverlayStyle lightMode = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );

  // Dark Mode
  static SystemUiOverlayStyle darkMode = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );
}
