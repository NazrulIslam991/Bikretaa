import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherChip extends StatelessWidget {
  final String temperature;
  const WeatherChip({super.key, required this.temperature});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary.withAlpha((0.12 * 255).round()),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          Icon(Icons.wb_sunny_outlined, size: 16.r),
          SizedBox(width: 6.w),
          Text(
            temperature,
            style: theme.textTheme.bodySmall?.copyWith(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
