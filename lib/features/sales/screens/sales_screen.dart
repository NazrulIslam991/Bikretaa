import 'package:bikretaa/assets_path/assets_path.dart';
import 'package:bikretaa/features/sales/database/sales_screen_database.dart';
import 'package:bikretaa/features/sales/widgets/bottom_filter_sheet_for_sales.dart';
import 'package:bikretaa/features/sales/widgets/floating_menu_fab.dart';
import 'package:bikretaa/features/sales/widgets/sale_card/sales_history_card.dart';
import 'package:bikretaa/features/sales/widgets/sale_card/sales_summary_card.dart';
import 'package:bikretaa/features/sales/widgets/sale_screen_shimmer/sales_history_shimmer.dart';
import 'package:bikretaa/features/sales/widgets/sale_screen_shimmer/sales_summary_shimmer.dart';
import 'package:bikretaa/features/shared/presentation/widgets/search_bar/search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
    final theme = Theme.of(context);
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return Scaffold(body: Center(child: Text("user_not_logged_in".tr)));
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.h,
        title: CustomSearchBar(
          controller: searchController,
          onChanged: (value) =>
              setState(() => searchText = value.toLowerCase()),
          hintText: 'search_sales'.tr,
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
                        "sales_products".tr,
                        style: TextStyle(
                          fontSize: 21.h,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      Text(
                        "sales_summary".tr,
                        style: GoogleFonts.abhayaLibre(
                          fontSize: 15.h,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: _showFilterSheet,
                    icon: Image.asset(
                      AssetPaths.filterIcon,
                      width: 25.h,
                      height: 25.h,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),

              // Sales Summary
              StreamBuilder<QuerySnapshot>(
                stream: _salesScreenDatabase.getSalesFiltered(
                  startDate,
                  endDate,
                ),
                builder: (context, salesSnapshot) {
                  if (salesSnapshot.connectionState ==
                          ConnectionState.waiting ||
                      !salesSnapshot.hasData) {
                    return SalesSummaryShimmer();
                  }

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
                      if (revenueSnapshot.connectionState ==
                              ConnectionState.waiting ||
                          !revenueSnapshot.hasData) {
                        return SalesSummaryShimmer();
                      }

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
                                  value: totals["totalSales"] ?? 0.00,
                                  label: "sales".tr,
                                  bgColor: Color(0xFFFFC727),
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Expanded(
                                child: buildSummaryCard(
                                  value: totals["totalRevenue"] ?? 0.00,
                                  label: "revenue".tr,
                                  bgColor: Color(0xFF10B981),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Expanded(
                                child: buildSummaryCard(
                                  value: totals["totalDue"] ?? 0.00,
                                  label: "due".tr,
                                  bgColor: Color(0xFFFFC727),
                                  isPaidText: true,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Expanded(
                                child: buildSummaryCard(
                                  value: totals["totalPaid"] ?? 0.00,
                                  label: "paid".tr,
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
                "sales_history".tr,
                style: GoogleFonts.abhayaLibre(fontSize: 15.h),
              ),
              SizedBox(height: 10.h),

              /// Sales History
              StreamBuilder<QuerySnapshot>(
                stream: _salesScreenDatabase.getSalesFiltered(
                  startDate,
                  endDate,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return Center(child: SalesHistoryShimmer());
                  }

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
                    return SizedBox(
                      height: 0.4.sh,
                      child: Center(
                        child: Text(
                          "no_sales_found".tr,
                          style: TextStyle(
                            fontSize: 12.h,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
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
      floatingActionButton: FloatingMenuFAB(),
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

  Widget buildSummaryCard({
    required double value,
    required String label,
    Color bgColor = Colors.blue,
    String iconPath = AssetPaths.pie,
    bool isPaidText = false,
  }) {
    return SalesSummaryCard(
      amount: isPaidText
          ? (value == 0 ? 'BDT 0.00' : 'BDT ${value.toStringAsFixed(2)}')
          : 'BDT ${value.toStringAsFixed(2)}',
      label: label,
      bgColor: bgColor,
    );
  }

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
