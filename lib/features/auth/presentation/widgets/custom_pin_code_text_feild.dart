import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCodeField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onCompleted;
  final int length;
  final bool obscureText;
  final Color? activeColor;
  final Color? selectedColor;
  final Color? inactiveColor;
  final Color? activeFillColor;
  final Color? selectedFillColor;
  final Color? inactiveFillColor;

  const CustomPinCodeField({
    super.key,
    required this.controller,
    this.onCompleted,
    this.length = 6,
    this.obscureText = false,
    this.activeColor,
    this.selectedColor,
    this.inactiveColor,
    this.activeFillColor,
    this.selectedFillColor,
    this.inactiveFillColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PinCodeTextField(
      appContext: context,
      controller: controller,
      length: length,
      obscureText: obscureText,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      enableActiveFill: true,
      textStyle: TextStyle(
        color: theme.colorScheme.onPrimary,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 45.h,
        fieldWidth: 40.h,
        activeColor: activeColor ?? Colors.blue,
        activeFillColor: activeFillColor ?? Colors.blue.shade100,
        selectedColor: selectedColor ?? Colors.green,
        selectedFillColor: selectedFillColor ?? Colors.greenAccent.shade100,
        inactiveColor: inactiveColor ?? Colors.grey,
        inactiveFillColor: inactiveFillColor ?? Colors.grey.shade200,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      onCompleted: onCompleted,
    );
  }
}
