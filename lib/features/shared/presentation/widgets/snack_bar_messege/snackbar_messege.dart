// import 'package:flutter/material.dart';
//
// void showSnackbarMessage(BuildContext context, String message) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Reusable function to show a snackbar using GetX with context
void showSnackbarMessage(BuildContext context, String message) {
  Get.snackbar(
    'Notice', // Optional title
    message,
    snackPosition: SnackPosition.BOTTOM,
    //duration: const Duration(seconds: 3),
  );
}
