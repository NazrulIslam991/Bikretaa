import 'package:bikretaa/ui/widgets/custom_drawer.dart';
import 'package:bikretaa/ui/widgets/most_sold_product_card.dart';
import 'package:bikretaa/ui/widgets/summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.blueAccent.shade100,
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
        child: CustomDrawer(),
      ),
      body: SingleChildScrollView(
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
              "MD Nazrul Islam Nayon",
              style: GoogleFonts.italianno(
                textStyle: TextStyle(
                  color: Colors.black,
                  letterSpacing: .5,
                  fontSize: 20.h,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  //mainAxisSpacing: 2.h,
                  //crossAxisSpacing: 2.h,
                  childAspectRatio: 1.h / 1.6.h,
                ),
                itemBuilder: (context, index) {
                  return home_summary_card(
                    totalProducts: 1000,
                    CardTitle: 'Total Product',
                  );
                },
                itemCount: 6,
                //scrollDirection: Axis.vertical,
              ),
            ),

            //SizedBox(height: 15),
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
              padding: EdgeInsets.only(top: 0),
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
                physics: NeverScrollableScrollPhysics(),
              ),
            ),

            //SizedBox(height: 15),
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
                //height: 270,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 25.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/due_report.png',
                //height: 270,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }
}
