import 'package:bikretaa/database/sales_screen_database.dart';
import 'package:bikretaa/ui/screens/bottom_nav_bar/sales_product/add_sales_screen.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/sales_card_directories/sales_filter_sheet.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/sales_card_directories/sales_history_card.dart';
import 'package:bikretaa/ui/widgets/product_controller_feild/sales_card_directories/sales_summary_card.dart';
import 'package:bikretaa/ui/widgets/search_bar.dart';
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
  final SalesScreenDatabase _salesScreenDatabase = SalesScreenDatabase();

  TextEditingController searchController = TextEditingController();
  String searchText = "";
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    final todayRange = _salesScreenDatabase.getTodayRange();
    startDate = todayRange["start"];
    endDate = todayRange["end"];
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.h,
        backgroundColor: Colors.white10,
        title: CustomSearchBar(
          controller: searchController,
          onChanged: (value) =>
              setState(() => searchText = value.toLowerCase()),
          hintText: 'Search sales by ID or customer',
          prefixIcon: Icons.search,
          fontSize: 12,
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
                        "Sales summary",
                        style: GoogleFonts.italianno(fontSize: 20.h),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: _showFilterSheet,
                    icon: Image.asset(
                      'assets/images/filter_icon.png',
                      width: 25.h,
                      height: 25.h,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),

              /// Sales Summary
              StreamBuilder<QuerySnapshot>(
                stream: _salesScreenDatabase.getSalesFiltered(
                  startDate,
                  endDate,
                ),
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
                    stream: _salesScreenDatabase.getRevenueFiltered(
                      startDate,
                      endDate,
                    ),
                    builder: (context, revenueSnapshot) {
                      if (!revenueSnapshot.hasData)
                        return CircularProgressIndicator();

                      final totals = _salesScreenDatabase.calculateTotals(
                        salesDocs,
                        revenueSnapshot.data!.docs,
                      );

                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: buildSummaryCard(
                                  value: totals["totalSales"]!,
                                  label: "Sales",
                                  bgColor: Color(0xFFFFC727),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: buildSummaryCard(
                                  value: totals["totalRevenue"]!,
                                  label: "Revenue",
                                  bgColor: Color(0xFF10B981),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Expanded(
                                child: buildSummaryCard(
                                  value: totals["totalDue"]!,
                                  label: "Due",
                                  bgColor: Color(0xFFFFC727),
                                  isPaidText: true,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: buildSummaryCard(
                                  value: totals["totalPaid"]!,
                                  label: "Paid",
                                  bgColor: Color(0xFF10B981),
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
                "Sales history",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.h),
              ),
              SizedBox(height: 10.h),

              /// Sales History
              StreamBuilder<QuerySnapshot>(
                stream: _salesScreenDatabase.getSalesFiltered(
                  startDate,
                  endDate,
                ),
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

                  if (salesDocs.isEmpty) {
                    return Center(
                      child: Text(
                        "No sales found",
                        style: TextStyle(
                          fontSize: 14.h,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: salesDocs.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final sale =
                          salesDocs[index].data() as Map<String, dynamic>;
                      final saleID = salesDocs[index].id;
                      return buildSalesHistoryCard(sale, saleID);
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

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return SalesFilterSheet(
          onFilterSelected: (start, end) {
            setState(() {
              startDate = start;
              endDate = end;
            });
          },
        );
      },
    );
  }

  //summary card
  Widget buildSummaryCard({
    required double value,
    required String label,
    Color bgColor = Colors.blue,
    String iconPath = 'assets/images/pie_chart.png',
    bool isPaidText = false,
  }) {
    return SalesSummaryCard(
      amount: isPaidText
          ? (value == 0 ? 'Paid' : 'BDT ${value.toStringAsFixed(2)}')
          : 'BDT ${value.toStringAsFixed(2)}',
      label: label,
      bgColor: bgColor,
      iconPath: iconPath,
    );
  }

  // sales history card
  Widget buildSalesHistoryCard(Map<String, dynamic> sale, String saleID) {
    int totalItems = (sale['products'] as List).length;
    double totalCost = (sale['products'] as List).fold(
      0.0,
      (sum, item) => sum + double.parse(item['totalPrice'].toString()),
    );

    DateTime saleDate = (sale['timestamp'] as Timestamp).toDate();

    return SalesHistoryCard(
      customerName: sale['customerName'],
      customerMobile: sale['customerMobile'],
      customerAddress: sale['customerAddress'],
      paymentType: sale['dueAmount'].toDouble() == 0 ? 'Paid' : 'Due',
      totalItems: totalItems,
      totalCost: totalCost,
      grandTotal: sale['grandTotal'].toDouble(),
      paidAmount: sale['paidAmount'].toDouble(),
      dueAmount: sale['dueAmount'].toDouble(),
      salesID: saleID,
      time:
          "${saleDate.hour.toString().padLeft(2, '0')}:${saleDate.minute.toString().padLeft(2, '0')}:${saleDate.second.toString().padLeft(2, '0')}",
      date:
          "${saleDate.year}-${saleDate.month.toString().padLeft(2, '0')}-${saleDate.day.toString().padLeft(2, '0')}",
    );
  }
}
