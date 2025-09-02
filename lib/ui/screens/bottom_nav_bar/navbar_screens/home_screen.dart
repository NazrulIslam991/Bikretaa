import 'package:bikretaa/app/shared_preferences_helper.dart';
import 'package:bikretaa/assets_path/assets_path.dart';
import 'package:bikretaa/ui/widgets/card/product_card/summary_card.dart';
import 'package:bikretaa/ui/widgets/card/sale_card/most_sold_product_card.dart';
import 'package:bikretaa/ui/widgets/drawer/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              size: 23.h,
              //color: theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),

      drawer: Container(
        height: double.infinity,
        width: 240.w,
        child: CustomDrawer(),
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
                    color: theme.textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.h,
                  ),
                ),
                Text(
                  shopName.isNotEmpty ? shopName : '',
                  style: GoogleFonts.abhayaLibre(
                    textStyle: TextStyle(
                      color: theme.textTheme.bodyMedium?.color,
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
                        imagePath: AssetPaths.mostProductSold,
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
                    AssetPaths.salesReport,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 25.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    AssetPaths.dueReport,
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
