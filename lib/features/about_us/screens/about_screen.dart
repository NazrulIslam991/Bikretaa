import 'package:bikretaa/assets_path/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("About Bikretaa", style: TextStyle(fontSize: 22.sp)),
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
                      "Bikretaa is a modern shop management app. It is designed specifically for shop owners to easily add products, track stock and expiry dates, manage due payments, and view detailed sales reports in one place.",
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
                "Why Bikretaa?",
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
                "Fast product management",
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
                "Stock and expiry date tracking",
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
                "Low stock & expiry alerts",
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
                "Sales reports & analytics",
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
                "Secure login & account management",
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
                "Developed by:",
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
                "© 2025 Bikretaa Team. All Rights Reserved.",
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
