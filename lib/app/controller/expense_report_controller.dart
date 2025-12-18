import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../features/reports/models/chart_data/chart_data.dart';

class ExpenseReportController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String get uid => FirebaseAuth.instance.currentUser?.uid ?? "";

  var investmentData = <ChartData>[].obs;
  var isLoading = false.obs;

  var totalQuantity = 0.obs;
  var uniqueProductCount = 0.obs;

  ////////// Main Methods
  Future<void> fetchProductEntryCost(String range) async {
    if (uid.isEmpty) return;
    try {
      isLoading(true);

      totalQuantity.value = 0;
      uniqueProductCount.value = 0;
      Set<String> uniqueProductIds = {};

      Map<String, double> costMap = _generateBaseMap(range);

      QuerySnapshot productSnapshot = await _db
          .collection('Products')
          .doc(uid)
          .collection('products_list')
          .get();

      for (var doc in productSnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        DateTime? createdAt;
        if (data['createdAt'] is Timestamp) {
          createdAt = (data['createdAt'] as Timestamp).toDate();
        } else if (data['createdAt'] is String) {
          createdAt = DateTime.tryParse(data['createdAt']);
        }

        if (createdAt == null || !_isWithinRange(createdAt, range)) continue;

        String pId = data['productId'] ?? data['productName'] ?? "";
        if (pId.isNotEmpty) {
          uniqueProductIds.add(pId);
        }

        int quantity = (data['quantity'] ?? 0).toInt();
        totalQuantity.value += quantity;

        String key = _getFormatterKey(createdAt, range);
        double purchasePrice = (data['purchasePrice'] ?? 0.0).toDouble();
        double totalEntryCost = purchasePrice * quantity;

        if (costMap.containsKey(key)) {
          costMap[key] = costMap[key]! + totalEntryCost;
        }
      }

      uniqueProductCount.value = uniqueProductIds.length;

      List<ChartData> tempList = [];
      costMap.forEach((key, val) {
        tempList.add(ChartData(key, val, 0.0, 0.0));
      });
      investmentData.assignAll(tempList);
    } catch (e) {
      //print("Entry Cost Error: $e");
    } finally {
      isLoading(false);
    }
  }

  /////////// Helper Methods
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
      for (int i = 1; i <= 4; i++) {
        base["Wk $i"] = 0.0;
      }
    } else if (range == "Months") {
      for (int i = 1; i <= 12; i++) {
        base[DateFormat('MMM').format(DateTime(now.year, i))] = 0.0;
      }
    }
    return base;
  }

  //////////////// Date Range Check
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

  ////////////// Date Formatter Key
  String _getFormatterKey(DateTime date, String range) {
    if (range == "Today") return DateFormat('h a').format(date);
    if (range == "Days") return DateFormat('EEE').format(date);

    if (range == "Weeks") {
      DateTime now = DateTime.now();
      int daysAgo = now.difference(date).inDays;

      if (daysAgo >= 0 && daysAgo < 7) return "Wk 4";
      if (daysAgo >= 7 && daysAgo < 14) return "Wk 3";
      if (daysAgo >= 14 && daysAgo < 21) return "Wk 2";
      return "Wk 1";
    }

    return DateFormat('MMM').format(date);
  }

  ///////////////// Silent Methods for PDF Generation
  Future<Map<String, dynamic>> fetchProductEntryCostSilent(String range) async {
    if (uid.isEmpty) return {"totalQty": 0, "uniqueCount": 0};
    try {
      int totalQty = 0;
      Set<String> uniqueIds = {};

      QuerySnapshot snapshot = await _db
          .collection('Products')
          .doc(uid)
          .collection('products_list')
          .get();

      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        DateTime? createdAt;

        if (data['createdAt'] is Timestamp) {
          createdAt = (data['createdAt'] as Timestamp).toDate();
        } else if (data['createdAt'] is String) {
          createdAt = DateTime.tryParse(data['createdAt']);
        }

        if (createdAt != null && _isWithinRange(createdAt, range)) {
          uniqueIds.add(
            data['productId']?.toString() ??
                data['productName']?.toString() ??
                "Unknown",
          );

          var qtyData = data['quantity'] ?? 0;
          totalQty += (qtyData is num)
              ? qtyData.toInt()
              : int.tryParse(qtyData.toString()) ?? 0;
        }
      }
      return {"totalQty": totalQty, "uniqueCount": uniqueIds.length};
    } catch (e) {
      return {"totalQty": 0, "uniqueCount": 0};
    }
  }
}
