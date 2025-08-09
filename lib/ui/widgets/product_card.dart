import 'package:bikretaa/ui/screens/bottom_nav_bar/products/details_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCardWidget extends StatelessWidget {
  final String productName;
  final String category;
  final String totalUnit;
  final int unitPrice;
  final String imagePath;

  const ProductCardWidget({
    super.key,
    required this.productName,
    required this.category,
    required this.totalUnit,
    required this.unitPrice,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8,
      shadowColor: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.h)),
      child: SizedBox(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.h),
                topRight: Radius.circular(5.h),
              ),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 80.h,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.h,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    category,
                    style: TextStyle(fontSize: 10.h, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Total: $totalUnit units",
                    style: TextStyle(fontSize: 10.h, color: Colors.black),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$unitPrice tk",
                        style: GoogleFonts.italianno(
                          textStyle: TextStyle(
                            color: Colors.red,
                            letterSpacing: .5,
                            fontSize: 18.h,
                          ),
                        ),
                      ),
                      Container(
                        height: 18.h,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              DetailsProductScreen.name,
                            );
                          },

                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text(
                            "show more...",
                            style: GoogleFonts.abyssinicaSil(
                              textStyle: TextStyle(
                                color: Colors.blue,
                                letterSpacing: .5,
                                fontSize: 10.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
