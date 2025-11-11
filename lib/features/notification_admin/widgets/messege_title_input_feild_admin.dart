import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessegeTitleInputField_admin extends StatelessWidget {
  final TextEditingController controller;

  const MessegeTitleInputField_admin({super.key, required this.controller});

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

    return Container(
      height: 50.h,
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if ((value ?? '').isEmpty) {
            return "Title is required";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Enter notification title...",
          labelText: "Title",
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
