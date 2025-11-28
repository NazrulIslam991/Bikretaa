import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/assets_path/assets_path.dart';
import 'package:bikretaa/features/sales/database/customer_info_database.dart';
import 'package:bikretaa/features/sales/database/sales_screen_database.dart';
import 'package:bikretaa/features/sales/model/customer_model.dart';
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
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final SalesScreenDatabase _salesScreenDatabase = SalesScreenDatabase();
  final TextEditingController searchController = TextEditingController();
  final CustomerDatabase _customerDb = CustomerDatabase();

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
    final r = Responsive.of(context);
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return Scaffold(body: Center(child: Text("user_not_logged_in".tr)));
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: r.height(0.09),
        title: Padding(
          padding: EdgeInsets.only(top: r.height(0.02)),
          child: CustomSearchBar(
            controller: searchController,
            onChanged: (value) =>
                setState(() => searchText = value.toLowerCase()),
            hintText: 'search_sales'.tr,
            prefixIcon: Icons.search,
            fontSize: r.fontSmall(),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: r.height(0),
          horizontal: r.width(0.03),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "sales_products".tr,
                        style: r.textStyle(
                          fontSize: r.fontXXL(),
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      Text(
                        "sales_summary".tr,
                        style: GoogleFonts.abhayaLibre(
                          textStyle: r.textStyle(
                            fontSize: r.fontLarge(),
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: _showFilterSheet,
                    icon: Image.asset(
                      AssetPaths.filterIcon,
                      width: r.iconXXLarge(),
                      height: r.iconXXLarge(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: r.height(0.02)),

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
                    return (sale['customerUID'] ?? "")
                        .toString()
                        .toLowerCase()
                        .contains(searchText);
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
                                  bgColor: const Color(0xFFFFC727),
                                ),
                              ),
                              SizedBox(width: r.width(0.015)),
                              Expanded(
                                child: buildSummaryCard(
                                  value: totals["totalRevenue"] ?? 0.00,
                                  label: "revenue".tr,
                                  bgColor: const Color(0xFF10B981),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: r.height(0.012)),
                          Row(
                            children: [
                              Expanded(
                                child: buildSummaryCard(
                                  value: totals["totalDue"] ?? 0.00,
                                  label: "due".tr,
                                  bgColor: const Color(0xFFFFC727),
                                  isPaidText: true,
                                ),
                              ),
                              SizedBox(width: r.width(0.015)),
                              Expanded(
                                child: buildSummaryCard(
                                  value: totals["totalPaid"] ?? 0.00,
                                  label: "paid".tr,
                                  bgColor: const Color(0xFF10B981),
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

              SizedBox(height: r.height(0.02)),

              Text(
                "sales_history".tr,
                style: GoogleFonts.abhayaLibre(
                  textStyle: r.textStyle(fontSize: r.fontLarge()),
                ),
              ),
              SizedBox(height: r.height(0.015)),

              // Sales History
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

                  final salesDocs = snapshot.data!.docs.toList();

                  if (salesDocs.isEmpty) {
                    return SizedBox(
                      height: r.height(0.4),
                      child: Center(
                        child: Text(
                          "no_sales_found".tr,
                          style: r.textStyle(
                            fontSize: r.fontMedium(),
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
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final saleDoc = salesDocs[index];
                      final saleData = saleDoc.data() as Map<String, dynamic>;
                      final saleID = saleDoc.id;
                      final customerUID = saleData['customerUID'] ?? "";

                      return FutureBuilder<CustomerModel?>(
                        future: _customerDb.fetchCustomer(uid, customerUID),
                        builder: (context, customerSnapshot) {
                          if (customerSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SalesHistoryShimmer();
                          }
                          final customer = customerSnapshot.data;
                          return buildSalesHistoryCard(
                            saleData,
                            saleID,
                            customer,
                            customerUID,
                          );
                        },
                      );
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
    final r = Responsive.of(context);
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(r.radiusMedium()),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (context) => SalesFilterSheet(
        onFilterSelected: (start, end) {
          setState(() {
            startDate = start;
            endDate = end;
          });
        },
      ),
    );
  }

  Widget buildSummaryCard({
    required double value,
    required String label,
    Color bgColor = Colors.blue,
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

  Widget buildSalesHistoryCard(
    Map<String, dynamic> sale,
    String saleID,
    CustomerModel? customer,
    String customerUID,
  ) {
    int totalItems = (sale['products'] as List).length;
    double totalCost = (sale['products'] as List).fold(
      0.0,
      (sum, item) => sum + double.parse(item['totalPrice'].toString()),
    );

    DateTime saleDate = (sale['timestamp'] as Timestamp).toDate();

    return SalesHistoryCard(
      customerName: customer?.name ?? "Unknown",
      customerMobile: customer?.mobile ?? "-",
      customerAddress: customer?.address ?? "-",
      paymentType: sale['dueAmount'].toDouble() == 0 ? 'Paid' : 'Due',
      totalItems: totalItems,
      totalCost: totalCost,
      grandTotal: sale['grandTotal'].toDouble(),
      paidAmount: sale['paidAmount'].toDouble(),
      dueAmount: sale['dueAmount'].toDouble(),
      salesID: saleID,
      customerUID: customerUID,
      time:
          "${saleDate.hour.toString().padLeft(2, '0')}:${saleDate.minute.toString().padLeft(2, '0')}:${saleDate.second.toString().padLeft(2, '0')}",
      date:
          "${saleDate.year}-${saleDate.month.toString().padLeft(2, '0')}-${saleDate.day.toString().padLeft(2, '0')}",
    );
  }
}
