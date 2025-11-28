import 'package:bikretaa/features/sales/database/sales_screen_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SalesController extends GetxController {
  final SalesScreenDatabase _salesDb = SalesScreenDatabase();

  String? get uid => _salesDb.uid;

  // ---------------- TODAY ----------------
  RxDouble todaySales = 0.0.obs;
  RxDouble todayRevenue = 0.0.obs;
  RxDouble todayPaid = 0.0.obs;
  RxDouble todayDue = 0.0.obs;
  RxList<QueryDocumentSnapshot> todaySalesHistory =
      <QueryDocumentSnapshot>[].obs;

  // ---------------- WEEK ----------------
  RxDouble weekSales = 0.0.obs;
  RxDouble weekRevenue = 0.0.obs;
  RxDouble weekPaid = 0.0.obs;
  RxDouble weekDue = 0.0.obs;
  RxList<QueryDocumentSnapshot> weekSalesHistory =
      <QueryDocumentSnapshot>[].obs;

  // ---------------- MONTH ----------------
  RxDouble monthSales = 0.0.obs;
  RxDouble monthRevenue = 0.0.obs;
  RxDouble monthPaid = 0.0.obs;
  RxDouble monthDue = 0.0.obs;
  RxList<QueryDocumentSnapshot> monthSalesHistory =
      <QueryDocumentSnapshot>[].obs;

  // ---------------- YEAR ----------------
  RxDouble yearSales = 0.0.obs;
  RxDouble yearRevenue = 0.0.obs;
  RxDouble yearPaid = 0.0.obs;
  RxDouble yearDue = 0.0.obs;
  RxList<QueryDocumentSnapshot> yearSalesHistory =
      <QueryDocumentSnapshot>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodayTotalsAndHistory();
    fetchWeekTotalsAndHistory();
    fetchMonthTotalsAndHistory();
    fetchYearTotalsAndHistory();
  }

  // --- TODAY ---
  void fetchTodayTotalsAndHistory() {
    final todayRange = _salesDb.getTodayRange();

    _salesDb.getSalesFiltered(todayRange["start"], todayRange["end"]).listen((
      salesSnap,
    ) {
      final totals = _salesDb.calculateTotals(salesSnap.docs, const []);
      todaySales.value = totals["totalSales"]!;
      todayPaid.value = totals["totalPaid"]!;
      todayDue.value = totals["totalDue"]!;
      todaySalesHistory.assignAll(salesSnap.docs);
    });

    _salesDb.getRevenueFiltered(todayRange["start"], todayRange["end"]).listen((
      revSnap,
    ) {
      double revenueTotal = 0.0;
      for (var doc in revSnap.docs) {
        revenueTotal += doc["totalRevenue"].toDouble();
      }
      todayRevenue.value = revenueTotal;
    });
  }

  // --- WEEK ---
  void fetchWeekTotalsAndHistory() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = DateTime(now.year, now.month, now.day, 23, 59, 59);

    _salesDb.getSalesFiltered(startOfWeek, endOfWeek).listen((salesSnap) {
      final totals = _salesDb.calculateTotals(salesSnap.docs, const []);
      weekSales.value = totals["totalSales"]!;
      weekPaid.value = totals["totalPaid"]!;
      weekDue.value = totals["totalDue"]!;
      weekSalesHistory.assignAll(salesSnap.docs);
    });

    _salesDb.getRevenueFiltered(startOfWeek, endOfWeek).listen((revSnap) {
      double revenueTotal = 0.0;
      for (var doc in revSnap.docs) {
        revenueTotal += doc["totalRevenue"].toDouble();
      }
      weekRevenue.value = revenueTotal;
    });
  }

  // --- MONTH ---
  void fetchMonthTotalsAndHistory() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month, now.day, 23, 59, 59);

    _salesDb.getSalesFiltered(startOfMonth, endOfMonth).listen((salesSnap) {
      final totals = _salesDb.calculateTotals(salesSnap.docs, const []);
      monthSales.value = totals["totalSales"]!;
      monthPaid.value = totals["totalPaid"]!;
      monthDue.value = totals["totalDue"]!;
      monthSalesHistory.assignAll(salesSnap.docs);
    });

    _salesDb.getRevenueFiltered(startOfMonth, endOfMonth).listen((revSnap) {
      double revenueTotal = 0.0;
      for (var doc in revSnap.docs) {
        revenueTotal += doc["totalRevenue"].toDouble();
      }
      monthRevenue.value = revenueTotal;
    });
  }

  // --- YEAR ---
  void fetchYearTotalsAndHistory() {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    final endOfYear = DateTime(now.year, now.month, now.day, 23, 59, 59);

    _salesDb.getSalesFiltered(startOfYear, endOfYear).listen((salesSnap) {
      final totals = _salesDb.calculateTotals(salesSnap.docs, const []);
      yearSales.value = totals["totalSales"]!;
      yearPaid.value = totals["totalPaid"]!;
      yearDue.value = totals["totalDue"]!;
      yearSalesHistory.assignAll(salesSnap.docs);
    });

    _salesDb.getRevenueFiltered(startOfYear, endOfYear).listen((revSnap) {
      double revenueTotal = 0.0;
      for (var doc in revSnap.docs) {
        revenueTotal += doc["totalRevenue"].toDouble();
      }
      yearRevenue.value = revenueTotal;
    });
  }
}
