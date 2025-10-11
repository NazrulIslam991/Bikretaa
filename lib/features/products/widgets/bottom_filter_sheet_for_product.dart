import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ProductFilter { all, lowStock, expired, expireSoon, aToZ, zToA }

typedef ProductFilterCallback = void Function(ProductFilter filter);

class ProductFilterSheet extends StatelessWidget {
  final ProductFilterCallback onFilterSelected;

  const ProductFilterSheet({super.key, required this.onFilterSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(width: 40.w, height: 4.h),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    "Filter Products",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                Column(
                  children: ProductFilter.values.map((filter) {
                    String title;
                    IconData icon;
                    Color color;

                    switch (filter) {
                      case ProductFilter.all:
                        title = "All Products";
                        icon = Icons.all_inbox;
                        color = Colors.blue;
                        break;
                      case ProductFilter.lowStock:
                        title = "Low Stock";
                        icon = Icons.warning;
                        color = Colors.orange;
                        break;
                      case ProductFilter.expired:
                        title = "Expired";
                        icon = Icons.block;
                        color = Colors.red;
                        break;
                      case ProductFilter.expireSoon:
                        title = "Expire Soon";
                        icon = Icons.timer;
                        color = Colors.purple;
                        break;
                      case ProductFilter.aToZ:
                        title = "A → Z";
                        icon = Icons.sort_by_alpha;
                        color = Colors.green;
                        break;
                      case ProductFilter.zToA:
                        title = "Z → A";
                        icon = Icons.sort_by_alpha;
                        color = Colors.indigo;
                        break;
                    }

                    return Card(
                      color: theme.cardColor,
                      elevation: 2,
                      shadowColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5.h),
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 4.h,
                          horizontal: 10.w,
                        ),
                        leading: CircleAvatar(
                          radius: 12.r,
                          backgroundColor: color.withOpacity(0.15),
                          child: Icon(icon, color: color, size: 14.sp),
                        ),
                        title: Text(
                          title,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 12.sp),
                        onTap: () {
                          onFilterSelected(filter);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
