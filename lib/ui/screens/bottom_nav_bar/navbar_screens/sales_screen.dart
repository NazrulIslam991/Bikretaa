import 'package:bikretaa/database/sales_screen_database.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/sales_product/add_sales_screen.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/sales_card_directories/sales_history_card.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/sales_card_directories/sales_summary_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final SalesScreenDatabase _repo = SalesScreenDatabase();

  TextEditingController searchController = TextEditingController();
  String searchText = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   Navigator.pushReplacementNamed(context, '/login');
      // });
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.h,
        backgroundColor: Colors.white10,
        title: SizedBox(
          height: 40.h,
          child: TextField(
            controller: searchController,
            onChanged: (value) =>
                setState(() => searchText = value.toLowerCase()),
            decoration: InputDecoration(
              hintText: 'Search sales by ID or customer...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            style: TextStyle(fontSize: 16.sp),
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
                        "Today’s sales summary",
                        style: GoogleFonts.italianno(fontSize: 20.h),
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

              StreamBuilder<QuerySnapshot>(
                stream: _repo.getTodaySales(),
                builder: (context, salesSnapshot) {
                  if (!salesSnapshot.hasData)
                    return CircularProgressIndicator();
                  final salesDocs = salesSnapshot.data!.docs.where((doc) {
                    final sale = doc.data() as Map<String, dynamic>;
                    final customerName = sale['customerName']
                        .toString()
                        .toLowerCase();
                    final salesID = doc.id.toLowerCase();
                    return customerName.contains(searchText) ||
                        salesID.contains(searchText);
                  }).toList();

                  return StreamBuilder<QuerySnapshot>(
                    stream: _repo.getTodayRevenue(),
                    builder: (context, revenueSnapshot) {
                      if (!revenueSnapshot.hasData)
                        return CircularProgressIndicator();

                      final totals = _repo.calculateTotals(
                        salesDocs,
                        revenueSnapshot.data!.docs,
                      );

                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SalesSummaryCard(
                                  amount:
                                      'BDT ${totals["totalSales"]!.toStringAsFixed(2)}',
                                  label: "Today's Sales",
                                  bgColor: Color(0xFFFFC727),
                                  iconPath: 'assets/images/pie_chart.png',
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: SalesSummaryCard(
                                  amount:
                                      'BDT ${totals["totalRevenue"]!.toStringAsFixed(2)}',
                                  label: "Today's Revenue",
                                  bgColor: Color(0xFF10B981),
                                  iconPath: 'assets/images/pie_chart.png',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Expanded(
                                child: SalesSummaryCard(
                                  amount: totals["totalDue"] == 0
                                      ? 'Paid'
                                      : 'BDT ${totals["totalDue"]!.toStringAsFixed(2)}',
                                  label: "Today's Due",
                                  bgColor: Color(0xFFFFC727),
                                  iconPath: 'assets/images/pie_chart.png',
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: SalesSummaryCard(
                                  amount:
                                      'BDT ${totals["totalPaid"]!.toStringAsFixed(2)}',
                                  label: "Today's Paid",
                                  bgColor: Color(0xFF10B981),
                                  iconPath: 'assets/images/pie_chart.png',
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),

              SizedBox(height: 15.h),
              Text(
                "Today's sales history",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.h),
              ),
              SizedBox(height: 10.h),

              StreamBuilder<QuerySnapshot>(
                stream: _repo.getTodaySales(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  final salesDocs = snapshot.data!.docs.where((doc) {
                    final sale = doc.data() as Map<String, dynamic>;
                    final customerName = sale['customerName']
                        .toString()
                        .toLowerCase();
                    final salesID = doc.id.toLowerCase();
                    return customerName.contains(searchText) ||
                        salesID.contains(searchText);
                  }).toList();

                  if (salesDocs.isEmpty)
                    return Center(child: Text("No sales today"));

                  return ListView.builder(
                    itemCount: salesDocs.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var sale =
                          salesDocs[index].data() as Map<String, dynamic>;
                      int totalItems = (sale['products'] as List).length;
                      double totalCost = (sale['products'] as List).fold(
                        0.0,
                        (sum, item) =>
                            sum + double.parse(item['totalPrice'].toString()),
                      );

                      Timestamp timestamp = sale['timestamp'] as Timestamp;
                      DateTime saleDate = timestamp.toDate();

                      return SalesHistoryCard(
                        customerName: sale['customerName'],
                        customerMobile: sale['customerMobile'],
                        customerAddress: sale['customerAddress'],
                        paymentType: sale['dueAmount'].toDouble() == 0
                            ? 'Paid'
                            : 'Due',
                        totalItems: totalItems,
                        totalCost: totalCost,
                        grandTotal: sale['grandTotal'].toDouble(),
                        paidAmount: sale['paidAmount'].toDouble(),
                        dueAmount: sale['dueAmount'].toDouble(),
                        salesID: salesDocs[index].id,
                        time:
                            "${saleDate.hour.toString().padLeft(2, '0')}:${saleDate.minute.toString().padLeft(2, '0')}:${saleDate.second.toString().padLeft(2, '0')}",
                        date:
                            "${saleDate.year}-${saleDate.month.toString().padLeft(2, '0')}-${saleDate.day.toString().padLeft(2, '0')}",
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AddSalesScreen.name),
        backgroundColor: Colors.blueGrey.shade50,
        foregroundColor: Colors.blueGrey,
        child: Icon(Icons.add_box_outlined, size: 20.h),
      ),
    );
  }
}
