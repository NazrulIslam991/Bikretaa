import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Search...',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      child: TextField(
        controller: controller,
        autofocus: false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.grey,
            letterSpacing: 0.4,
            fontSize: 12.h,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
