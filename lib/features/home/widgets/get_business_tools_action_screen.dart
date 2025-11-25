import 'package:bikretaa/features/calculator/screens/calculator.dart';
import 'package:bikretaa/features/calender/screen/calender_screen.dart';
import 'package:bikretaa/features/notes/screens/notes_screen.dart';
import 'package:bikretaa/features/qr_code/screens/qr_code_generator.dart';
import 'package:bikretaa/features/qr_code/screens/qr_code_scanner.dart';
import 'package:bikretaa/features/supports_and_faqs/screens/support_and_faqs_screen.dart';
import 'package:bikretaa/features/unit_converter/screens/unit_converter_screen.dart';
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
