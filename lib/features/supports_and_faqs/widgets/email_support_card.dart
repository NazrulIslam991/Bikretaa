import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmailSupportCard extends StatelessWidget {
  final ThemeData theme;
  final VoidCallback onPressed;

  const EmailSupportCard({
    super.key,
    required this.theme,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final blue = const Color(0xFF007BFF);
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'email_support_desc'.tr,
            style: TextStyle(
              fontSize: 13.sp,
              color: theme.colorScheme.onSurface.withOpacity(0.85),
            ),
          ),
          SizedBox(height: 12.h),
          ElevatedButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.mail_outline, color: Colors.white),
            label: Text(
              'contact_support'.tr,
              style: TextStyle(fontSize: 14.sp),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: blue,
              minimumSize: Size(double.infinity, 25.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
