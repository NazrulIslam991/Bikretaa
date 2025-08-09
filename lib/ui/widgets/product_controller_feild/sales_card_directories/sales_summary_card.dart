import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SalesSummaryCard extends StatelessWidget {
  final String amount;
  final String label;
  final Color bgColor;
  final String iconPath;

  const SalesSummaryCard({
    super.key,
    required this.amount,
    required this.label,
    required this.bgColor,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(13.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              iconPath,
              width: 20.w,
              height: 20.h,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
