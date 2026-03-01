import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class UpdateSalesShimmerScreen extends StatelessWidget {
  const UpdateSalesShimmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade600 : Colors.grey.shade100;

    return Scaffold(
      appBar: AppBar(
        title: Text("update_sale".tr, style: TextStyle(fontSize: 22.sp)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerBox(height: 50.h),
              SizedBox(height: 10.h),

              _shimmerBox(height: 50.h),
              SizedBox(height: 10.h),

              _shimmerBox(height: 80.h),
              SizedBox(height: 20.h),

              _shimmerBox(height: 180.h),

              SizedBox(height: 20.h),

              Row(
                children: [
                  Expanded(child: _shimmerBox(height: 50.h)),
                  SizedBox(width: 10.w),
                  Expanded(child: _shimmerBox(height: 50.h)),
                  SizedBox(width: 10.w),
                  _shimmerBox(width: 40.w, height: 40.h, radius: 10.r),
                ],
              ),
              SizedBox(height: 20.h),

              Row(
                children: [
                  Expanded(child: _shimmerBox(height: 50.h)),
                  SizedBox(width: 10.w),
                  Expanded(child: _shimmerBox(height: 50.h)),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12.h),
        child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
      ),
    );
  }

  Widget _shimmerBox({double? width, double? height, double radius = 8}) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 40.h,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }
}
