import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class ConverterInputFeild extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final VoidCallback onClear;

  const ConverterInputFeild({
    super.key,
    required this.controller,
    required this.label,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: r.fontMedium()),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: r.fontSmall()),
        prefixIcon: Icon(Icons.numbers, size: r.iconSmall()),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear, size: r.iconSmall()),
          onPressed: onClear,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(r.radiusMedium()),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: r.height(0.02),
          horizontal: r.width(0.03),
        ),
      ),
    );
  }
}
