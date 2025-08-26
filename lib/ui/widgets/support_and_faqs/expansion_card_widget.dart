import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpansionCard extends StatelessWidget {
  final String title;
  final String? description;
  final Color? titleColor;

  const ExpansionCard({
    super.key,
    required this.title,
    this.description,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 2,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
        childrenPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: titleColor ?? Colors.black,
          ),
        ),
        children: description != null
            ? [
                Text(
                  description!,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ]
            : [],
      ),
    );
  }
}
