import 'package:bikretaa/features/sales/screens/update_sell_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SalesHistoryCard extends StatelessWidget {
  final String customerName;
  final String customerMobile;
  final String customerAddress;
  final String paymentType;
  final int totalItems;
  final double totalCost;
  final double paidAmount;
  final double dueAmount;
  final double grandTotal;
  final String time;
  final String date;
  final String salesID;

  const SalesHistoryCard({
    Key? key,
    required this.customerName,
    required this.customerMobile,
    required this.customerAddress,
    required this.paymentType,
    required this.totalItems,
    required this.totalCost,
    required this.paidAmount,
    required this.dueAmount,
    required this.grandTotal,
    required this.time,
    required this.date,
    required this.salesID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(left: 0.w, right: 0.w, bottom: 10.h),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2.r,
              blurRadius: 5.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: Column(
          children: [
            // Top section (customer info)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          customerName,
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Center(
                        child: Text(
                          customerMobile,
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Address: $customerAddress",
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  dueAmount == 0
                      ? 'Paid'
                      : 'Due: ${dueAmount.toStringAsFixed(2)} tk',
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            SizedBox(height: 5.h),

            // Inner Container
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Items : ',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            totalItems.toString(),
                            style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: 10.sp,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Cost : ',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            'BDT ${totalCost.toStringAsFixed(2)} tk',
                            style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: 10.sp,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Paid Amount : ',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            '${paidAmount.toStringAsFixed(2)} tk',
                            style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: 10.sp,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Due Amount : ',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            'BDT ${dueAmount.toStringAsFixed(2)} tk',
                            style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: 10.sp,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sell ID : ',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            salesID,
                            style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: 10.sp,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: salesID));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Sales ID copied to clipboard'),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.copy,
                              size: 12.h,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Edit button (top-right corner)
                Positioned(
                  right: 5.w,
                  top: 5.h,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UpdateSalesScreen(salesID: salesID),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit, color: Colors.white, size: 14.h),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
