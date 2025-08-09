import 'package:bikretaa/ui/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsProductScreen extends StatelessWidget {
  const DetailsProductScreen({super.key});
  static const String name = 'DetailsProductScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details", style: TextStyle(fontSize: 22.h)),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(0.h),
              child: Image.asset(
                "assets/images/most_products_sold.jpeg",
                width: double.infinity,
                height: 170.h,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              child: Text(
                "Product Name",
                style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
              child: Text(
                "Categories Name and Sub-Categories",
                style: GoogleFonts.italianno(
                  textStyle: TextStyle(
                    color: Colors.black,
                    letterSpacing: .5,
                    fontSize: 18.h,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 25.h,
                left: 25.h,
                top: 15.h,
                bottom: 10.h,
              ),
              child: Text(
                "Product information",
                style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.bold),
              ),
            ),
            Divider_widget(),
            Padding(
              padding: EdgeInsetsGeometry.only(
                right: 20.h,
                left: 20.h,
                top: 10.h,
                bottom: 10.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Quantity in Stock",
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "150",
                        style: TextStyle(
                          fontSize: 12.h,
                          color: Colors.blue,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Product Code",
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "TOM-0054",
                        style: TextStyle(
                          fontSize: 12.h,
                          color: Colors.blue,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider_widget(),
            Padding(
              padding: EdgeInsetsGeometry.only(
                right: 20.h,
                left: 20.h,
                top: 10.h,
                bottom: 10.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Purchase Price",
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "150 tk",
                        style: TextStyle(
                          fontSize: 12.h,
                          color: Colors.blue,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Selling Price",
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '200 tk',
                        style: TextStyle(
                          fontSize: 12.h,
                          color: Colors.blue,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider_widget(),
            Padding(
              padding: EdgeInsetsGeometry.only(
                right: 20.h,
                left: 20.h,
                top: 10.h,
                bottom: 10.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Manufacture Date",
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "01/02/2025",
                        style: TextStyle(
                          fontSize: 12.h,
                          color: Colors.blue,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Expiry Date",
                        style: TextStyle(
                          fontSize: 14.h,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "01/02/2026",
                        style: TextStyle(
                          fontSize: 12.h,
                          color: Colors.blue,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                right: 20.h,
                left: 20.h,
                top: 25.h,
                bottom: 10.h,
              ),
              child: Text(
                "Product Description",
                style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 20.h,
                left: 20.h,
                top: 5.h,
                bottom: 30.h,
              ),
              child: Text(
                "This premium quality Basmati rice is ideal for everyday cooking and special occasions. Grown in the fertile plains, it offers a rich aroma and long, fluffy grains after cooking. Perfect for biryani, pulao, or steamed rice dishes. Hygienically packed to preserve freshness and nutrition.",
                style: GoogleFonts.ibarraRealNova(
                  textStyle: TextStyle(
                    color: Colors.black,
                    letterSpacing: .5,
                    fontSize: 14.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40.h,
              width: 90.w,
              child: ElevatedButton(onPressed: () {}, child: Text("Edit")),
            ),
            Container(
              height: 40.h,
              width: 90.w,
              child: ElevatedButton(onPressed: () {}, child: Text("Delete")),
            ),
          ],
        ),
      ),
    );
  }
}
