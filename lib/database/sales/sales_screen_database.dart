import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SalesScreenDatabase {
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get uid => _auth.currentUser?.uid;

  // Get today's start and end times
  Map<String, DateTime> getTodayRange() {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    return {"start": startOfDay, "end": endOfDay};
  }

  // Sales query for today
  Stream<QuerySnapshot> getTodaySalesFiltered() {
    final range = getTodayRange();
    return getSalesFiltered(range["start"], range["end"]);
  }

  // Revenue query for today
  Stream<QuerySnapshot> getTodayRevenueFiltered() {
    final range = getTodayRange();
    return getRevenueFiltered(range["start"], range["end"]);
  }

  // General sales query with date range
  Stream<QuerySnapshot> getSalesFiltered(DateTime? start, DateTime? end) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    var ref = FirebaseFirestore.instance
        .collection('Sales')
        .doc(uid)
        .collection('sales_list')
        .orderBy('timestamp', descending: true);

    if (start != null && end != null) {
      ref = ref.where(
        'timestamp',
        isGreaterThanOrEqualTo: start,
        isLessThanOrEqualTo: end,
      );
    }
    return ref.snapshots();
  }

  // General revenue query with date range
  Stream<QuerySnapshot> getRevenueFiltered(DateTime? start, DateTime? end) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    Query<Map<String, dynamic>> ref = FirebaseFirestore.instance
        .collection('Revenue')
        .doc(uid)
        .collection('revenue_list');

    if (start != null && end != null) {
      ref = ref.where(
        'timestamp',
        isGreaterThanOrEqualTo: start,
        isLessThanOrEqualTo: end,
      );
    }
    return ref.snapshots();
  }

  // Helper: calculate totals
  Map<String, double> calculateTotals(
    List<QueryDocumentSnapshot> salesDocs,
    List<QueryDocumentSnapshot> revenueDocs,
  ) {
    double totalSales = 0.0;
    double totalPaid = 0.0;
    double totalDue = 0.0;
    double totalRevenue = 0.0;

    for (var doc in salesDocs) {
      var sale = doc.data() as Map<String, dynamic>;
      totalSales += sale['grandTotal'].toDouble();
      totalPaid += sale['paidAmount'].toDouble();
      totalDue += sale['dueAmount'].toDouble();
    }

    for (var doc in revenueDocs) {
      var revenue = doc.data() as Map<String, dynamic>;
      totalRevenue += revenue['totalRevenue'].toDouble();
    }

    return {
      "totalSales": totalSales,
      "totalPaid": totalPaid,
      "totalDue": totalDue,
      "totalRevenue": totalRevenue,
    };
  }
}
