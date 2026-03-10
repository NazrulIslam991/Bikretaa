import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/user/sales/presentation/models/customer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../database/customer_due_database.dart';
import '../models/customer_due_model.dart';

class CustomerDueScreen extends StatefulWidget {
  final CustomerModel customer;
  final String shopUID;

  const CustomerDueScreen({
    super.key,
    required this.customer,
    required this.shopUID,
  });

  @override
  State<CustomerDueScreen> createState() => _CustomerDueScreenState();
}

class _CustomerDueScreenState extends State<CustomerDueScreen> {
  final CustomerDueDatabase _dueDatabase = CustomerDueDatabase();
  late Future<List<CustomerDueModel>> _duesFuture;

  @override
  void initState() {
    super.initState();

    _duesFuture = _dueDatabase.fetchCustomerDues(
      shopUID: widget.shopUID,
      customerUID: widget.customer.customerId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Due History",style: TextStyle(fontSize: 22.sp),),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),

      body: FutureBuilder<List<CustomerDueModel>>(
        future: _duesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No Due History",
                style: TextStyle(fontSize: 16, color: theme.textTheme.titleSmall?.color),
              ),
            );
          }

          final dues = snapshot.data!;
          double totalDue = dues.fold(0, (sum, item) => sum + item.amount);

          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(r.paddingMedium()),
                    itemCount: dues.length,
                    itemBuilder: (context, index) {
                      return DetailedDueCard(
                        due: dues[index],
                        shopUID: widget.shopUID,
                        dueDatabase: _dueDatabase,
                        r: r,
                        theme: theme,
                      );
                    },
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              margin: EdgeInsets.fromLTRB(r.paddingMedium(), 0, r.paddingMedium(), r.paddingLarge()),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, -5),
                  ),
                ],
                border: Border.all(color: Colors.red.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 20),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Total Due",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                  Text(
                    "৳ ${totalDue.toStringAsFixed(0)}",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: r.fontLarge() + 2,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
            ),          );
        },
      ),
    );
  }
}

class DetailedDueCard extends StatelessWidget {
  final CustomerDueModel due;
  final String shopUID;
  final CustomerDueDatabase dueDatabase;
  final Responsive r;
  final ThemeData theme;

  const DetailedDueCard({
    super.key,
    required this.due,
    required this.shopUID,
    required this.dueDatabase,
    required this.r,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: dueDatabase.fetchSaleInfo(shopUID, due.salesID),
      builder: (context, saleSnap) {
        String date = "";
        String bill = "0";
        String paid = "0";

        if (saleSnap.hasData && saleSnap.data != null) {
          final data = saleSnap.data!;
          final ts = data['timestamp'];
          if (ts is Timestamp) {
            date = DateFormat("dd MMM yyyy • hh:mm a").format(ts.toDate());
          }
          bill = data['grandTotal'].toString();
          paid = data['paidAmount'].toString();
        }

        return Container(
          margin: EdgeInsets.only(bottom: r.height(.02)),
          padding: EdgeInsets.all(r.paddingMedium()),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: theme.brightness == Brightness.dark
                    ? Colors.black54
                    : Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// DATE + DUE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: theme.brightness == Brightness.dark ? Colors.grey[400] : Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        date,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: theme.textTheme.titleSmall?.color),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Due ৳${due.amount}",
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 10),

              /// BILL + PAID
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Bill: ৳$bill", style: TextStyle(color: theme.textTheme.titleSmall?.color)),
                  Text(
                    "Paid: ৳$paid",
                    style: const TextStyle(color: Colors.green),
                  )
                ],
              ),

              const Divider(height: 20),

              /// PRODUCTS
              FutureBuilder<List<Map<String, dynamic>>>(
                future: dueDatabase.fetchSaleProducts(shopUID, due.salesID),
                builder: (context, prodSnap) {
                  if (prodSnap.connectionState == ConnectionState.waiting) {
                    return const LinearProgressIndicator();
                  }

                  final products = prodSnap.data ?? [];

                  return Column(
                    children: products.map((p) {
                      double total = (p['totalSellAmount'] as num?)?.toDouble() ?? 0;
                      int qty = (p['quantitySold'] as num?)?.toInt() ?? 1;
                      double unit = total / qty;

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.brightness == Brightness.dark ? Colors.grey.shade800 : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.shopping_bag, size: 18, color: theme.brightness == Brightness.dark ? Colors.grey[400] : Colors.grey),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                p['productName'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: theme.textTheme.titleSmall?.color,
                                ),
                              ),
                            ),
                            Text(
                              "$qty x ৳${unit.toStringAsFixed(0)}",
                              style: TextStyle(
                                color: theme.brightness == Brightness.dark ? Colors.grey[400] : Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "৳${total.toStringAsFixed(0)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.textTheme.titleLarge?.color,
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),

              const Divider(),

              /// INVOICE
              Row(
                children: [
                  Icon(Icons.receipt_long, size: 14, color: theme.brightness == Brightness.dark ? Colors.grey[400] : Colors.grey),
                  const SizedBox(width: 6),
                  Text(
                    "Invoice ID: ${due.salesID}",
                    style: TextStyle(
                      fontSize: 11,
                      color: theme.textTheme.titleSmall?.color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}