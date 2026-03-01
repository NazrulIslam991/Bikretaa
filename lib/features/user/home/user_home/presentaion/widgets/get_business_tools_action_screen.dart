import 'package:bikretaa/features/user/home/calculator/presentaion/screens/calculator.dart';
import 'package:bikretaa/features/user/home/calender/presentation/screens/calender_screen.dart';
import 'package:bikretaa/features/user/home/notes/presentation/screens/notes_screen.dart';
import 'package:bikretaa/features/user/home/qr_code/presentaion/screens/qr_code_generator.dart';
import 'package:bikretaa/features/user/home/qr_code/presentaion/screens/qr_code_scanner.dart';
import 'package:bikretaa/features/user/settings/supports_and_faqs/presentaion/screens/support_and_faqs_screen.dart';
import 'package:bikretaa/features/user/home/unit_converter/presentaion/screens/unit_converter_screen.dart';
import 'package:flutter/material.dart';

Widget getBusinessToolScreenByTitle(String title) {
  switch (title) {
    case "Customer Support":
      return SupportFaqScreen();
    case "Calculator":
      return Calculator();
    case "Calender":
      return CalendarScreen();
    case "QR Scanner":
      return QRScannerScreen();
    case "QR Generator":
      return QRGeneratorScreen();
    case "Notes":
      return NotesScreen();
    case "Unit Converter":
      return UnitConverterScreen();
    default:
      return Scaffold(body: Center(child: Text("Screen not found")));
  }
}
