import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Divider_widget extends StatelessWidget {
  const Divider_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1.h,
      thickness: 1.h,
      indent: 25.h,
      endIndent: 25.h,
      color: Colors.grey,
    );
  }
}
