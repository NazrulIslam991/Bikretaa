import 'package:flutter/material.dart';

import '../../../app/responsive.dart';

class NotificationDropdownFieldAdmin extends StatelessWidget {
  final String value;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final String label;

  const NotificationDropdownFieldAdmin({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);
    final fillColor = theme.inputDecorationTheme.fillColor ?? theme.cardColor;
    final labelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.primary,
    );

    return SizedBox(
      height: r.height(0.06),
      child: DropdownButtonFormField<String>(
        value: value,
        items: options
            .map(
              (option) => DropdownMenuItem(value: option, child: Text(option)),
            )
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: labelStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(r.radiusMedium()),
          ),
          filled: true,
          fillColor: fillColor,
          contentPadding: EdgeInsets.symmetric(
            horizontal: r.width(0.03),
            vertical: r.height(0.015),
          ),
        ),
      ),
    );
  }
}
