import 'package:bikretaa/assets_path/assets_path.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/navbar_screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class home_summary_card extends StatelessWidget {
  final int totalProducts;
  final String CardTitle;

  const home_summary_card({
    super.key,
    required this.totalProducts,
    required this.CardTitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.cardColor,
      elevation: 5.h,
      shadowColor: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.h)),
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20.h,
                backgroundColor: Colors.green.shade100,
                child: ClipOval(
                  child: SizedBox(
                    width: 20.h,
                    height: 20.w,
                    child: Image.asset(AssetPaths.doller, fit: BoxFit.contain),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                CardTitle,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.blue.shade400,
                  fontSize: 12.h,
                ),
              ),
              Text(
                "$totalProducts",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.h),
              ),
              SizedBox(
                height: 28.h,
                child: TextButton(
                  onPressed: () {
                    _onTapProductPage(context);
                  },
                  child: Text(
                    "Show Details",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.blue.shade400,
                      fontSize: 10.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapProductPage(BuildContext context) {
    Navigator.pushNamed(context, ProductsScreen.name);
  }
}
