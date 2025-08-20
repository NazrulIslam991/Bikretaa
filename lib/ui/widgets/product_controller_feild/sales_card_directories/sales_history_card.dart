import 'package:flutter/material.dart';
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

  SalesHistoryCard({
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
    return Padding(
      padding: EdgeInsets.only(left: 0.w, right: 0.w, bottom: 10.h),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Color(0xFF1D9BF0),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
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
                            color: Colors.white,
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
                            color: Colors.white70,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Address: $customerAddress",
                          style: TextStyle(
                            color: Colors.white70,
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
                      : 'Due:${dueAmount.toStringAsFixed(2)} tk',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                color: Colors.white,
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
                          color: Colors.indigo,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        totalItems.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
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
                          color: Colors.indigo,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        'BDT ${totalCost.toStringAsFixed(2)} tk',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
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
                          color: Colors.indigo,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        '${paidAmount.toStringAsFixed(2)} tk',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
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
                          color: Colors.indigo,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        'BDT ${dueAmount.toStringAsFixed(2)} tk',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
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
                          color: Colors.indigo,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        salesID,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
