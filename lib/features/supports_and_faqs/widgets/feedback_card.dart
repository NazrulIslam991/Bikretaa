import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FeedbackCard extends StatelessWidget {
  final ThemeData theme;
  final TextEditingController controller;
  final int charCount;
  final Function(String) onChanged;
  final VoidCallback onSend;

  const FeedbackCard({
    super.key,
    required this.theme,
    required this.controller,
    required this.charCount,
    required this.onChanged,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final green = const Color(0xFF28A745);
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
        children: [
          Text(
            'feedback_desc'.tr,
            style: TextStyle(
              fontSize: 13.sp,
              color: theme.colorScheme.onSurface.withOpacity(0.85),
            ),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: controller,
            maxLines: 5,
            maxLength: 500,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: 'feedback_hint'.tr,
              hintStyle: TextStyle(
                fontWeight: FontWeight.normal,
                color: theme.colorScheme.primary,
                letterSpacing: 0.4,
                fontSize: 11.h,
              ),
              counterText: "",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                '$charCount/500',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(Icons.check_circle_outline, color: green, size: 12.sp),
                  SizedBox(width: 6.w),
                  Text(
                    'instant_admin_notif'.tr,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ElevatedButton.icon(
            onPressed: onSend,
            icon: const Icon(Icons.send),
            label: Text('send_message'.tr, style: TextStyle(fontSize: 15.sp)),
            style: ElevatedButton.styleFrom(
              backgroundColor: green,
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
