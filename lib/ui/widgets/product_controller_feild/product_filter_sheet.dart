import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ProductFilter { all, lowStock, aToZ, zToA }

typedef ProductFilterCallback = void Function(ProductFilter filter);

class ProductFilterSheet extends StatelessWidget {
  final ProductFilterCallback onFilterSelected;

  const ProductFilterSheet({super.key, required this.onFilterSelected});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 60.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Center(
                child: Text(
                  "Filter Products",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.h),

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
                      color = Colors.red;
                      break;
                    case ProductFilter.aToZ:
                      title = "A → Z";
                      icon = Icons.sort_by_alpha;
                      color = Colors.green;
                      break;
                    case ProductFilter.zToA:
                      title = "Z → A";
                      icon = Icons.sort_by_alpha;
                      color = Colors.purple;
                      break;
                  }

                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: color.withOpacity(0.2),
                        child: Icon(icon, color: color, size: 16.h),
                      ),
                      title: Text(
                        title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16.h),
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
    );
  }
}
