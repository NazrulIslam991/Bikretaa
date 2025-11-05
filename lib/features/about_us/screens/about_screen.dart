import 'package:bikretaa/assets_path/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("about_bikretaa".tr, style: TextStyle(fontSize: 22.sp)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Logo & Name
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40.r,
                    backgroundColor: Colors.blue.shade100,
                    backgroundImage: AssetImage(AssetPaths.logo),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Bikretaa",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Text(
                      "bikretaa_description".tr,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // Why Bikretaa
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Text(
                "why_bikretaa".tr,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.speed, color: Colors.blue),
              title: Text(
                "fast_product_management".tr,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.inventory, color: Colors.blue),
              title: Text(
                "stock_and_expiry_tracking".tr,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.notifications_active, color: Colors.blue),
              title: Text(
                "low_stock_alerts".tr,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.bar_chart, color: Colors.blue),
              title: Text(
                "sales_reports".tr,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.security, color: Colors.blue),
              title: Text(
                "secure_login".tr,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 25.h),

            // Team Section
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Text(
                "developed_by".tr,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _teamMember("Md N.I. Nayon", AssetPaths.nayon),
                _teamMember("Md Nasim", AssetPaths.logo),
                _teamMember("Toha Fardin", AssetPaths.fardin),
              ],
            ),
            SizedBox(height: 25.h),

            // Footer
            Center(
              child: Text(
                "footer_text".tr,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Team Member Card
  Widget _teamMember(String name, String imagePath) {
    return Column(
      children: [
        CircleAvatar(radius: 25.r, backgroundImage: AssetImage(imagePath)),
        SizedBox(height: 6.h),
        SizedBox(
          width: 80.w,
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
