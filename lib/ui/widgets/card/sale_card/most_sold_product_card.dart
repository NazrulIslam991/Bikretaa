import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Most_Sold_Product_Card extends StatelessWidget {
  final String ProductName;
  final int soldProductUnit;
  final int totalSoldPrice;
  final String imagePath;

  const Most_Sold_Product_Card({
    super.key,
    required this.ProductName,
    required this.soldProductUnit,
    required this.totalSoldPrice,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.h)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.h),
              child: Image.asset(
                imagePath,
                height: 70.h,
                width: 90.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.h),

            // Product Info (Name + Quantity)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ProductName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.h,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '$soldProductUnit units sold',
                    style: TextStyle(fontSize: 12.h, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Total Amount
            Text(
              '+$totalSoldPrice tk',
              style: TextStyle(
                fontSize: 14.h,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
