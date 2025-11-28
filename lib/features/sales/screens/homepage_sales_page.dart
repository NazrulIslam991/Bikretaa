import 'package:bikretaa/app/controller/sales_controller/sales_controller.dart';
import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/sales/model/customer_model.dart';
import 'package:bikretaa/features/sales/widgets/sale_card/sales_history_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../database/customer_info_database.dart';
import '../widgets/sale_card/homepage_sales_summary_card.dart';

class SalesSummaryScreen extends StatelessWidget {
  final String title;
  final SalesController salesController = Get.find<SalesController>();
  final CustomerDatabase customerDb = CustomerDatabase();

  SalesSummaryScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    // Select period
    RxList<QueryDocumentSnapshot> salesHistory;
    RxDouble salesTotal;
    RxDouble revenueTotal;
    RxDouble paidTotal;
    RxDouble dueTotal;

    if (title == "Last Week Sales") {
      salesHistory = salesController.weekSalesHistory;
      salesTotal = salesController.weekSales;
      revenueTotal = salesController.weekRevenue;
      paidTotal = salesController.weekPaid;
      dueTotal = salesController.weekDue;
    } else if (title == "Last Month Sales") {
      salesHistory = salesController.monthSalesHistory;
      salesTotal = salesController.monthSales;
      revenueTotal = salesController.monthRevenue;
      paidTotal = salesController.monthPaid;
      dueTotal = salesController.monthDue;
    } else {
      salesHistory = <QueryDocumentSnapshot>[].obs;
      salesTotal = 0.0.obs;
      revenueTotal = 0.0.obs;
      paidTotal = 0.0.obs;
      dueTotal = 0.0.obs;
    }
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontSize: r.fontXL(),
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: r.width(0.03),
          vertical: r.height(0.02),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- SUMMARY CARDS ---
              Text(
                "Sales Summary",
                style: TextStyle(
                  fontSize: r.fontLarge(),
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: r.height(0.015)),
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: HomePageSalesSummaryCard(
                        label: "Sales",
                        amount: salesTotal.value,
                      ),
                    ),
                    SizedBox(width: r.width(0.015)),
                    Expanded(
                      child: HomePageSalesSummaryCard(
                        label: "Revenue",
                        amount: revenueTotal.value,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: r.height(0.015)),
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: HomePageSalesSummaryCard(
                        label: "Paid",
                        amount: paidTotal.value,
                      ),
                    ),
                    SizedBox(width: r.width(0.015)),
                    Expanded(
                      child: HomePageSalesSummaryCard(
                        label: "Due",
                        amount: dueTotal.value,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: r.height(0.01)),

              // --- SALES HISTORY ---
              Text(
                "Sales History",
                style: TextStyle(
                  fontSize: r.fontLarge(),
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: r.height(0.015)),
              Obx(() {
                if (salesHistory.isEmpty) {
                  return SizedBox(
                    height: r.height(0.4),
                    child: const Center(child: Text("No sales found")),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: salesHistory.length,
                  itemBuilder: (context, index) {
                    final saleDoc = salesHistory[index];
                    final sale = saleDoc.data() as Map<String, dynamic>;

                    DateTime saleDate = (sale['timestamp'] as Timestamp)
                        .toDate();
                    int totalItems = (sale['products'] as List).length;
                    double totalCost = (sale['products'] as List).fold(
                      0.0,
                      (sum, item) =>
                          sum + double.parse(item['totalPrice'].toString()),
                    );

                    final String customerUID = sale['customerUID'] ?? "";

                    return FutureBuilder<CustomerModel?>(
                      future: customerUID.isNotEmpty
                          ? customerDb.fetchCustomer(
                              salesController.uid!,
                              customerUID,
                            )
                          : Future.value(null),
                      builder: (context, snapshot) {
                        final customer = snapshot.data;
                        final customerName =
                            customer?.name ?? sale['customerName'] ?? "Unknown";
                        final customerMobile =
                            customer?.mobile ?? sale['customerMobile'] ?? "-";
                        final customerAddress =
                            customer?.address ?? sale['customerAddress'] ?? "-";

                        return SalesHistoryCard(
                          customerName: customerName,
                          customerMobile: customerMobile,
                          customerAddress: customerAddress,
                          paymentType: sale['dueAmount'].toDouble() == 0
                              ? 'Paid'
                              : 'Due',
                          totalItems: totalItems,
                          totalCost: totalCost,
                          grandTotal: sale['grandTotal'].toDouble(),
                          paidAmount: sale['paidAmount'].toDouble(),
                          dueAmount: sale['dueAmount'].toDouble(),
                          salesID: saleDoc.id,
                          customerUID: customerUID,
                          time:
                              "${saleDate.hour.toString().padLeft(2, '0')}:${saleDate.minute.toString().padLeft(2, '0')}",
                          date:
                              "${saleDate.year}-${saleDate.month.toString().padLeft(2, '0')}-${saleDate.day.toString().padLeft(2, '0')}",
                        );
                      },
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
