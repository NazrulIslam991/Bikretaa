import 'package:bikretaa/database/signin_and_signup/shared_preferences_helper.dart';
import 'package:bikretaa/ui/widgets/custom_drawer.dart';
import 'package:bikretaa/ui/widgets/most_sold_product_card.dart';
import 'package:bikretaa/ui/widgets/summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: Text(
          "Home",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, size: 23.h),
          ),
        ],
      ),

      drawer: Container(
        height: double.infinity,
        width: 240.w,
        child: const CustomDrawer(),
      ),

      body: FutureBuilder(
        future: SharedPreferencesHelper.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading user data"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("No user data found"));
          }

          final user = snapshot.data!;
          final shopName = user.shopName;

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome,",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.h,
                  ),
                ),
                Text(
                  shopName.isNotEmpty ? shopName : '',
                  style: GoogleFonts.abhayaLibre(
                    textStyle: TextStyle(
                      color: Colors.black,
                      letterSpacing: .5,
                      fontSize: 18.h,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.h / 1.7.h,
                    ),
                    itemBuilder: (context, index) {
                      return home_summary_card(
                        totalProducts: 1000,
                        CardTitle: 'Total Product',
                      );
                    },
                    itemCount: 6,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Most Sold Products",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.h,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Show Details...",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 10.h,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Most_Sold_Product_Card(
                        ProductName: 'Product Name',
                        soldProductUnit: 199,
                        totalSoldPrice: 1200,
                        imagePath: 'assets/images/most_products_sold.jpeg',
                      );
                    },
                    itemCount: 4,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sales and Due Report",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.h,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Show Details...",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 10.h,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),

                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/sales_report.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 25.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/due_report.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 5.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
