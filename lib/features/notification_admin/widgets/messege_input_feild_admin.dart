import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageInputField_Admin extends StatelessWidget {
  final TextEditingController controller;

  const MessageInputField_Admin({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fillColor = theme.inputDecorationTheme.fillColor ?? theme.cardColor;
    final labelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.primary,
    );
    final hintStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.hintColor,
    );

    return SizedBox(
      height: 120.h, // Fixed height
      child: TextFormField(
        controller: controller,
        maxLines: 5, // Adjust to fill height
        textInputAction: TextInputAction.newline,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if ((value ?? '').isEmpty) {
            return "Message is required";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Enter your message...",
          labelText: "Message",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
          filled: true,
          fillColor: fillColor,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 14.h,
          ),
          labelStyle: labelStyle,
          hintStyle: hintStyle,
        ),
      ),
    );
  }
}
