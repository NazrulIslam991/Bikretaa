import 'package:bikretaa/ui/widgets/product_controller_feild/sales_card_directories/sales_history_card.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/sales_card_directories/sales_summary_card.dart';
import 'package:bikretaa/ui/widgets/snackbar_messege.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  TextEditingController searchController = TextEditingController();
  String searchText = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.h,
        backgroundColor: Colors.white10,
        title: SizedBox(
          height: 40.h,
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
              if (value.isNotEmpty) {
                showSnackbarMessage(context, searchText);
              }
            },
            decoration: InputDecoration(
              hintText: 'Search sales...',
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(vertical: 8.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            style: TextStyle(fontSize: 16.sp),
            textInputAction: TextInputAction.search,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sales Products",
                        style: TextStyle(
                          fontSize: 25.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Today 100 products have been sold !!!",
                        style: GoogleFonts.italianno(
                          textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 20.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/images/filter_icon.png',
                      width: 25.h,
                      height: 25.h,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 5.h,
                    childAspectRatio: 1.5.h / 0.7.h,
                  ),
                  itemBuilder: (context, index) {
                    return SalesSummaryCard(
                      amount: "52,980 tk",
                      label: (index % 2 == 0) ? "Today's Sales" : "Today's due",
                      bgColor: (index % 2 == 0)
                          ? Color(0xFFFFC727) // Yellow-like
                          : Color(0xFF10B981), // Teal/Green
                      iconPath: 'assets/images/pie_chart.png',
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
                      "Today's sales history",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.h,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Show mores...",
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
              ListView.builder(
                itemBuilder: (context, index) {
                  return SalesHistoryCard(
                    customerName: 'Customer Name',
                    paymentType: 'Cash',
                    totalItems: 5,
                    totalCost: 1000.0,
                    discountPercentage: 10.0,
                    discountAmount: 100.0,
                    grandTotal: 900.0,
                    time: '11:55:43',
                    date: '12/08/2025',
                  );
                },
                itemCount: 4,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          onPressed: () {
            //Navigator.pushNamed(context, AddProductScreen.name);
          },
          backgroundColor: Colors.blueGrey.shade50,
          foregroundColor: Colors.blueGrey,
          child: Icon(Icons.add_box_outlined, size: 20.h),
        ),
      ),
    );
  }
}
