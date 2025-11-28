import 'package:bikretaa/features/sales/database/sales_screen_database.dart';
import 'package:get/get.dart';

class SalesSummaryController extends GetxController {
  final SalesScreenDatabase _salesDb = SalesScreenDatabase();

  // Global variables
  // --- TODAY ---
  RxDouble todaySales = 0.0.obs;
  RxDouble todayRevenue = 0.0.obs;
  RxDouble todayPaid = 0.0.obs;
  RxDouble todayDue = 0.0.obs;

  // --- WEEK ---
  RxDouble weekSales = 0.0.obs;
  RxDouble weekRevenue = 0.0.obs;
  RxDouble weekPaid = 0.0.obs;
  RxDouble weekDue = 0.0.obs;

  // --- MONTH ---
  RxDouble monthSales = 0.0.obs;
  RxDouble monthRevenue = 0.0.obs;
  RxDouble monthPaid = 0.0.obs;
  RxDouble monthDue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodayTotals();
    fetchWeekTotals();
    fetchMonthTotals();
  }

  /// ---------------- TODAY ----------------
  void fetchTodayTotals() {
    final todayRange = _salesDb.getTodayRange();

    // SALES
    _salesDb.getSalesFiltered(todayRange["start"], todayRange["end"]).listen((
      salesSnap,
    ) {
      final totals = _salesDb.calculateTotals(salesSnap.docs, const []);
      todaySales.value = totals["totalSales"]!;
      todayPaid.value = totals["totalPaid"]!;
      todayDue.value = totals["totalDue"]!;
    });

    // REVENUE
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

  /// ---------------- WEEK ----------------
  void fetchWeekTotals() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = DateTime(
      now.year,
      now.month,
      now.day,
      23,
      59,
      59,
    ); // today end

    _salesDb.getSalesFiltered(startOfWeek, endOfWeek).listen((salesSnap) {
      final totals = _salesDb.calculateTotals(salesSnap.docs, const []);
      weekSales.value = totals["totalSales"]!;
      weekPaid.value = totals["totalPaid"]!;
      weekDue.value = totals["totalDue"]!;
    });

    _salesDb.getRevenueFiltered(startOfWeek, endOfWeek).listen((revSnap) {
      double revenueTotal = 0.0;
      for (var doc in revSnap.docs) {
        revenueTotal += doc["totalRevenue"].toDouble();
      }
      weekRevenue.value = revenueTotal;
    });
  }

  /// ---------------- MONTH ----------------
  void fetchMonthTotals() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(
      now.year,
      now.month,
      now.day,
      23,
      59,
      59,
    ); // today end

    _salesDb.getSalesFiltered(startOfMonth, endOfMonth).listen((salesSnap) {
      final totals = _salesDb.calculateTotals(salesSnap.docs, const []);
      monthSales.value = totals["totalSales"]!;
      monthPaid.value = totals["totalPaid"]!;
      monthDue.value = totals["totalDue"]!;
    });

    _salesDb.getRevenueFiltered(startOfMonth, endOfMonth).listen((revSnap) {
      double revenueTotal = 0.0;
      for (var doc in revSnap.docs) {
        revenueTotal += doc["totalRevenue"].toDouble();
      }
      monthRevenue.value = revenueTotal;
    });
  }
}
