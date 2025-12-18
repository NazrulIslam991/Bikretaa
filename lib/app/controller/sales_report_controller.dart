import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../features/reports/models/chart_data/chart_data.dart';

class SalesReportController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String get uid => FirebaseAuth.instance.currentUser?.uid ?? "";

  var dateRange = "Today".obs;
  var chartData = <ChartData>[].obs;
  var isLoading = false.obs;

  var salesTrendPercent = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    if (uid.isNotEmpty) {
      fetchSalesData(dateRange.value);
    }
  }

  ////////// Main Methods
  Future<void> fetchSalesData(String range) async {
    if (uid.isEmpty) return;
    try {
      isLoading(true);

      double currentPeriodSales = 0.0;
      double previousPeriodSales = 0.0;
      Map<String, int> productSalesCount = {};

      Map<String, double> salesMap = _generateBaseMap(range);
      Map<String, double> revenueMap = _generateBaseMap(range);
      Map<String, double> dueMap = _generateBaseMap(range);

      QuerySnapshot salesSnapshot = await _db
          .collection('Sales')
          .doc(uid)
          .collection('sales_list')
          .get();

      //DateTime now = DateTime.now();

      for (var doc in salesSnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        if (data['timestamp'] == null) continue;

        DateTime date = (data['timestamp'] as Timestamp).toDate();
        double total = (data['grandTotal'] ?? 0.0).toDouble();

        if (_isWithinRange(date, range)) {
          currentPeriodSales += total;
          String key = _getFormatterKey(date, range);
          if (salesMap.containsKey(key)) {
            salesMap[key] = salesMap[key]! + total;
            dueMap[key] = dueMap[key]! + (data['dueAmount'] ?? 0.0).toDouble();
          }

          if (data['items'] != null) {
            for (var item in data['items']) {
              String pName = item['productName'] ?? "Unknown";
              int qty = (item['quantity'] ?? 0).toInt();
              productSalesCount[pName] = (productSalesCount[pName] ?? 0) + qty;
            }
          }
        } else if (_isWithinPreviousRange(date, range)) {
          previousPeriodSales += total;
        }
      }

      if (previousPeriodSales == 0) {
        salesTrendPercent.value = currentPeriodSales > 0 ? 100.0 : 0.0;
      } else {
        salesTrendPercent.value =
            ((currentPeriodSales - previousPeriodSales) / previousPeriodSales) *
            100;
      }

      QuerySnapshot revSnapshot = await _db
          .collection('Revenue')
          .doc(uid)
          .collection('revenue_list')
          .get();
      for (var doc in revSnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        DateTime date = (data['timestamp'] as Timestamp).toDate();
        if (_isWithinRange(date, range)) {
          String key = _getFormatterKey(date, range);
          if (revenueMap.containsKey(key)) {
            revenueMap[key] =
                revenueMap[key]! + (data['totalRevenue'] ?? 0.0).toDouble();
          }
        }
      }

      List<ChartData> tempList = [];
      salesMap.forEach((key, val) {
        tempList.add(
          ChartData(key, val, revenueMap[key] ?? 0.0, dueMap[key] ?? 0.0),
        );
      });
      chartData.assignAll(tempList);
    } catch (e) {
      debugPrint("Report Error: $e");
    } finally {
      isLoading(false);
      update();
    }
  }

  //////////// Helper Methods
  bool _isWithinPreviousRange(DateTime date, String range) {
    DateTime now = DateTime.now();

    if (range == "Today") {
      DateTime yesterday = now.subtract(const Duration(days: 1));
      return date.year == yesterday.year &&
          date.month == yesterday.month &&
          date.day == yesterday.day;
    }

    if (range == "Days") {
      DateTime start = now.subtract(const Duration(days: 14));
      DateTime end = now.subtract(const Duration(days: 7));
      return date.isAfter(start) && date.isBefore(end);
    }

    if (range == "Weeks") {
      DateTime start = now.subtract(const Duration(days: 56));
      DateTime end = now.subtract(const Duration(days: 28));
      return date.isAfter(start) && date.isBefore(end);
    }

    if (range == "Months") {
      return date.year == (now.year - 1);
    }
    return false;
  }

  //////// Trend Calculation
  void calculateTrend(double current, double previous) {
    if (previous == 0) {
      salesTrendPercent.value = current > 0 ? 100.0 : 0.0;
    } else {
      salesTrendPercent.value = ((current - previous) / previous) * 100;
    }
  }

  ///////// Base Map Generation
  Map<String, double> _generateBaseMap(String range) {
    Map<String, double> base = {};
    DateTime now = DateTime.now();
    if (range == "Today") {
      for (int i = 0; i < 24; i++) {
        DateTime hour = DateTime(now.year, now.month, now.day, i);
        base[DateFormat('h a').format(hour)] = 0.0;
      }
    } else if (range == "Days") {
      for (int i = 6; i >= 0; i--) {
        DateTime day = now.subtract(Duration(days: i));
        base[DateFormat('EEE').format(day)] = 0.0;
      }
    } else if (range == "Weeks") {
      for (int i = 0; i < 4; i++) {
        base["Wk ${i + 1}"] = 0.0;
      }
    } else if (range == "Months") {
      for (int i = 1; i <= 12; i++) {
        base[DateFormat('MMM').format(DateTime(now.year, i))] = 0.0;
      }
    }
    return base;
  }

  ///////// Date Range Check
  bool _isWithinRange(DateTime date, String range) {
    DateTime now = DateTime.now();
    if (range == "Today") return date.day == now.day && date.month == now.month;
    if (range == "Days") {
      return date.isAfter(now.subtract(const Duration(days: 7)));
    }
    if (range == "Weeks") {
      return date.isAfter(now.subtract(const Duration(days: 28)));
    }
    if (range == "Months") return date.year == now.year;
    return false;
  }

  ////////// Date Formatter Key
  String _getFormatterKey(DateTime date, String range) {
    if (range == "Today") return DateFormat('h a').format(date);
    if (range == "Days") return DateFormat('EEE').format(date);
    if (range == "Weeks") {
      int daysAgo = DateTime.now().difference(date).inDays;
      if (daysAgo < 7) return "Wk 1";
      if (daysAgo < 14) return "Wk 2";
      if (daysAgo < 21) return "Wk 3";
      return "Wk 4";
    }
    return DateFormat('MMM').format(date);
  }

  ///// Silent Methods for PDF Generation
  Future<List<ChartData>> fetchSalesDataSilent(String range) async {
    if (uid.isEmpty) return [];
    try {
      Map<String, double> salesMap = _generateBaseMap(range);
      Map<String, double> revenueMap = _generateBaseMap(range);
      Map<String, double> dueMap = _generateBaseMap(range);

      QuerySnapshot salesSnapshot = await _db
          .collection('Sales')
          .doc(uid)
          .collection('sales_list')
          .get();

      for (var doc in salesSnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        if (data['timestamp'] == null) continue;
        DateTime date = (data['timestamp'] as Timestamp).toDate();

        if (_isWithinRange(date, range)) {
          double total = (data['grandTotal'] ?? 0.0).toDouble();
          String key = _getFormatterKey(date, range);
          if (salesMap.containsKey(key)) {
            salesMap[key] = salesMap[key]! + total;
            dueMap[key] = dueMap[key]! + (data['dueAmount'] ?? 0.0).toDouble();
          }
        }
      }

      QuerySnapshot revSnapshot = await _db
          .collection('Revenue')
          .doc(uid)
          .collection('revenue_list')
          .get();

      for (var doc in revSnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        DateTime date = (data['timestamp'] as Timestamp).toDate();
        if (_isWithinRange(date, range)) {
          String key = _getFormatterKey(date, range);
          if (revenueMap.containsKey(key)) {
            revenueMap[key] =
                revenueMap[key]! + (data['totalRevenue'] ?? 0.0).toDouble();
          }
        }
      }

      List<ChartData> list = [];
      salesMap.forEach((key, val) {
        list.add(
          ChartData(key, val, revenueMap[key] ?? 0.0, dueMap[key] ?? 0.0),
        );
      });
      return list;
    } catch (e) {
      return [];
    }
  }

  /////////// Trend Calculation Silent
  double calculateTrendSilent(List<ChartData> currentData) {
    try {
      double currentTotal = currentData.fold(
        0,
        (sum, item) => sum + item.sales,
      );
      if (currentTotal > 0) return 100.0;
      return 0.0;
    } catch (e) {
      return 0.0;
    }
  }
}
