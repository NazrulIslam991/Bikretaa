import 'package:bikretaa/ui/widgets/shimmer/product_screen_shimmer/ShimmerCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductsShimmerScreen extends StatelessWidget {
  const ProductsShimmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 30.h, width: 160.w, color: Colors.white),
                    SizedBox(height: 8.h),
                    Container(height: 20.h, width: 80.w, color: Colors.white),
                  ],
                ),
                Container(
                  height: 35.h,
                  width: 35.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              itemCount: 6,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 5.h,
                childAspectRatio: 1.h / 1.4.h,
              ),
              itemBuilder: (context, index) {
                return const ShimmerCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}
