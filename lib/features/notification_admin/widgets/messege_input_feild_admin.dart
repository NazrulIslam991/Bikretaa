import 'package:flutter/material.dart';

import '../../../app/responsive.dart';

class MessageInputField_Admin extends StatelessWidget {
  final TextEditingController controller;

  const MessageInputField_Admin({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);
    final fillColor = theme.inputDecorationTheme.fillColor ?? theme.cardColor;
    final labelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.primary,
    );
    final hintStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.hintColor,
    );

    return SizedBox(
      height: r.height(0.12),
      child: TextFormField(
        controller: controller,
        maxLines: 5,
        textInputAction: TextInputAction.newline,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) =>
            (value ?? '').isEmpty ? "Message is required" : null,
        decoration: InputDecoration(
          hintText: "Enter your message...",
          labelText: "Message",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(r.radiusMedium()),
          ),
          filled: true,
          fillColor: fillColor,
          contentPadding: EdgeInsets.symmetric(
            horizontal: r.width(0.035),
            vertical: r.height(0.02),
          ),
          labelStyle: labelStyle,
          hintStyle: hintStyle,
        ),
      ),
    );
  }
}
