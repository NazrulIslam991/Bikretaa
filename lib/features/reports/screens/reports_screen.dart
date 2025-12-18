import 'dart:typed_data' as td; // Prefix ব্যবহার করা হলো

import 'package:bikretaa/app/responsive.dart';
import 'package:bikretaa/features/reports/widgets/bikretaa_analytics_card.dart';
import 'package:bikretaa/features/reports/widgets/inventory_alert_tile.dart';
import 'package:bikretaa/features/reports/widgets/report_export_action.dart';
import 'package:bikretaa/features/reports/widgets/sales_revenue_trend_chart.dart';
import 'package:bikretaa/features/reports/widgets/stock_investment_analysis_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/controller/expense_report_controller.dart';
import '../../../app/controller/product_controller/product_controller.dart';
import '../../../app/controller/sales_report_controller.dart';
import '../services/report_analysis_pdf.dart';
import '../widgets/stock_distribution_chart.dart';

enum CombinedChartType { splineArea, column, line }

enum InventoryChartType { doughnut, pie }

enum ExpenseChartType { column, line }

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController; // Tab Controller for date ranges
  final List<String> _dateRanges = ["Today", "Days", "Weeks", "Months"];

  /// Current selected date range
  String dateRange = "Today";

  /// Default to "Today"

  final List<CombinedChartType> _combinedChartTypes = CombinedChartType.values;

  /// Available chart types for sales & profit
  int _currentCombinedChartTypeIndex = 0;

  /// Current selected chart type index
  CombinedChartType get _currentCombinedChartType =>
      _combinedChartTypes[_currentCombinedChartTypeIndex];

  /// Get current selected chart type
  final List<InventoryChartType> _inventoryChartTypes =
      InventoryChartType.values;

  /// Available chart types for inventory health
  int _currentInventoryChartTypeIndex = 0;

  /// Current selected chart type index
  InventoryChartType get _currentInventoryChartType =>
      _inventoryChartTypes[_currentInventoryChartTypeIndex];

  /// Get current selected chart type

  final List<ExpenseChartType> _expenseChartTypes = ExpenseChartType.values;

  /// Available chart types for expense analysis
  int _currentExpenseChartTypeIndex = 0;

  /// Current selected chart type index
  ExpenseChartType get _currentExpenseChartType =>
      _expenseChartTypes[_currentExpenseChartTypeIndex];

  /// Get current selected chart type

  final ProductController productController = Get.find<ProductController>();

  /// Product Controller instance
  final SalesReportController salesController = Get.put(
    SalesReportController(),
  );

  /// Sales Report Controller instance
  final ExpenseReportController expenseController = Get.put(
    ExpenseReportController(),
  );

  /// Expense Report Controller instance

  @override
  void initState() {
    super.initState();

    /// Initialize Tab Controller
    _tabController = TabController(
      length: _dateRanges.length,
      vsync: this,
      initialIndex: 0,
    );

    /// Fetch initial data after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });

    _tabController.addListener(_handleTabSelection);

    /// Listen for tab changes
  }

  /// Fetch data based on current date range
  void _fetchData() {
    salesController.fetchSalesData(dateRange);
    expenseController.fetchProductEntryCost(dateRange);
  }

  /// Handle tab selection changes
  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      setState(() {
        dateRange = _dateRanges[_tabController.index];
        _fetchData();
      });
    }
  }

  /// Handle cleanup
  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  /// Change chart types
  void _changeCombinedChartType() => setState(
    () => _currentCombinedChartTypeIndex =
        (_currentCombinedChartTypeIndex + 1) % _combinedChartTypes.length,
  );

  /// Change chart types
  void _changeInventoryChartType() => setState(
    () => _currentInventoryChartTypeIndex =
        (_currentInventoryChartTypeIndex + 1) % _inventoryChartTypes.length,
  );

  /// Change chart types
  void _changeExpenseChartType() => setState(
    () => _currentExpenseChartTypeIndex =
        (_currentExpenseChartTypeIndex + 1) % _expenseChartTypes.length,
  );

  /// Get trend period description based on date range
  String _getTrendPeriodDescription(String range) {
    switch (range) {
      case "Today":
        return "yesterday";
      case "Days":
        return "last day";
      case "Weeks":
        return "last week";
      case "Months":
        return "last month";
      default:
        return "last period";
    }
  }

  ////////// Build Method //////////
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final cardBackgroundColor = colorScheme.onPrimary;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "Business Reports",
              style: responsive.textStyle(
                fontSize: responsive.fontXXL(),
                fontWeight: FontWeight.bold,
                color:
                    theme.textTheme.titleLarge?.color ?? colorScheme.onSurface,
              ),
            ),
            centerTitle: true,
            backgroundColor: colorScheme.onPrimary,
            //foregroundColor: Colors.black,
            elevation: 0,
            floating: true,
            pinned: true,
            toolbarHeight: kToolbarHeight,

            bottom: PreferredSize(
              preferredSize: Size.fromHeight(responsive.height(0.075)),
              child: TabBar(
                controller: _tabController,
                isScrollable: false,
                indicatorColor: colorScheme.secondary,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: colorScheme.onSurface,
                unselectedLabelColor: colorScheme.onSurface.withValues(
                  alpha: 0.6,
                ),
                labelStyle: responsive.textStyle(
                  fontSize: responsive.fontSmall(),
                  fontWeight: FontWeight.bold,
                ),

                tabs: _dateRanges.map((range) => Tab(text: range)).toList(),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(responsive.paddingMedium()),
                child: Column(
                  children: [
                    /// Business Performance Banner
                    Obx(
                      () => _businessPerformanceBanner(
                        responsive,
                        salesController.salesTrendPercent.value,
                        _getTrendPeriodDescription(dateRange),
                        cardBackgroundColor,
                        isDark,
                      ),
                    ),
                    responsive.vSpace(0.01),

                    /// Sales & Profit Trend Card
                    BikretaaAnalyticsCard(
                      title: "Sales & Profit Trend ($dateRange)",
                      cardColor: cardBackgroundColor,
                      isDark: isDark,
                      headerChild: IconButton(
                        icon: const Icon(Icons.swap_horiz_outlined),
                        onPressed: _changeCombinedChartType,
                      ),
                      child: Obx(() {
                        if (salesController.isLoading.value) {
                          return const SizedBox(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return salesRevenueTrendChart(
                          context,
                          salesController.chartData,
                          responsive,
                          _currentCombinedChartType,
                        );
                      }),
                    ),

                    responsive.vSpace(0.01),

                    /// Inventory Health Card
                    Obx(() {
                      final int totalCount =
                          productController.allProducts.length;
                      final int outOfStockCount =
                          productController.outOfStockProducts.length;
                      final int lowStockCount =
                          productController.lowStockProducts.length;
                      final int expiredCount =
                          productController.expiredProducts.length;

                      final Map<String, int> dynamicStatus = {
                        "In Stock": (totalCount - outOfStockCount),
                        "Low Stock": lowStockCount,
                        "Out of Stock": outOfStockCount,
                        "Expired": expiredCount,
                      };

                      return BikretaaAnalyticsCard(
                        title: "Inventory Health",
                        cardColor: cardBackgroundColor,
                        isDark: isDark,
                        headerChild: IconButton(
                          icon: const Icon(Icons.swap_horiz, size: 20),
                          onPressed: _changeInventoryChartType,
                        ),
                        child: stockDistributionChart(
                          context,
                          dynamicStatus,
                          responsive,
                          _currentInventoryChartType,
                        ),
                      );
                    }),
                    responsive.vSpace(0.01),

                    /// Alerts Section
                    Obx(() {
                      if (productController.alerts.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return BikretaaAnalyticsCard(
                        title: "Smart Alerts",
                        cardColor: cardBackgroundColor,
                        isDark: isDark,
                        child: Column(
                          children: productController.alerts
                              .map((alert) => AlertListItem(alert: alert))
                              .toList(),
                        ),
                      );
                    }),

                    responsive.vSpace(0.01),

                    /// Expense Analysis Card
                    Obx(
                      () => BikretaaAnalyticsCard(
                        title: "Stock Entry Analysis ($dateRange)",
                        isDark: isDark,
                        cardColor: cardBackgroundColor,
                        headerChild: IconButton(
                          icon: const Icon(Icons.swap_horiz),
                          onPressed: _changeExpenseChartType,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _quickInsightMetric(
                                  "Total Items",
                                  "${expenseController.totalQuantity.value}",
                                  Colors.blue,
                                  responsive,
                                ),
                                _quickInsightMetric(
                                  "Unique Products",
                                  "${expenseController.uniqueProductCount.value}",
                                  Colors.purple,
                                  responsive,
                                ),
                              ],
                            ),
                            const Divider(height: 30),
                            expenseController.isLoading.value
                                ? const SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : stockInvestmentAnalysisChart(
                                    context,
                                    expenseController.investmentData,
                                    responsive,
                                    _currentExpenseChartType,
                                  ),
                          ],
                        ),
                      ),
                    ),

                    responsive.vSpace(0.01),

                    /// Export Buttons
                    Row(
                      children: [
                        // Export Section
                        Expanded(
                          child: ExportButton(
                            icon: Icons.picture_as_pdf,
                            text: "PDF",
                            color: Colors.red.shade700,
                            isFilled: false,

                            /// PDF Export Action
                            onPressed: () {
                              Get.bottomSheet(
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Export Options",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.print,
                                          color: Colors.blue,
                                        ),
                                        title: const Text("Print Report"),
                                        onTap: () async {
                                          Get.back();
                                          _handlePdfTask(
                                            context,
                                            isPrint: true,
                                          );
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.file_download,
                                          color: Colors.green,
                                        ),
                                        title: const Text("Download PDF"),
                                        onTap: () async {
                                          Get.back();
                                          _handlePdfTask(
                                            context,
                                            isPrint: false,
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        responsive.hSpace(0.04),

                        /// Excel Export Button
                        Expanded(
                          child: ExportButton(
                            icon: Icons.file_download,
                            text: "Excel",
                            color: Colors.blue.shade700,
                            isFilled: true,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    responsive.vSpace(0.01),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  //////////////////// Widgets ////////////////////
  Widget _businessPerformanceBanner(
    Responsive res,
    double trend,
    String period,
    Color bgColor,
    bool isDark,
  ) {
    Color color = trend > 0
        ? Colors.green.shade700
        : (trend < 0 ? Colors.red.shade700 : Colors.blue.shade700);

    IconData icon = trend > 0
        ? Icons.trending_up
        : (trend < 0 ? Icons.trending_down : Icons.trending_flat);

    return Container(
      padding: EdgeInsets.all(res.paddingMedium()),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(res.radiusSmall()),
        border: Border.all(
          color: isDark ? Colors.white24 : color.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: res.iconMedium()),
          res.hSpace(0.03),
          Expanded(
            child: Text(
              trend == 0
                  ? "Sales are stable compared to $period."
                  : "Sales ${trend > 0 ? 'increased' : 'decreased'} by ${trend.abs().toStringAsFixed(1)}% compared to $period.",
              style: res.textStyle(
                fontSize: res.fontSmall(),
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //////////// Widgets/////////////////
  Widget _quickInsightMetric(
    String label,
    String value,
    Color color,
    Responsive res,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: res.textStyle(
            fontSize: res.fontLarge(),
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: res.textStyle(color: Colors.grey, fontSize: res.fontSmall()),
        ),
      ],
    );
  }

  ////////// PDF Handling //////////
  Future<void> _handlePdfTask(
    BuildContext context, {
    required bool isPrint,
  }) async {
    Get.dialog(
      const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 15),
                Text(
                  "Processing Report...",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );

    try {
      final td.Uint8List pdfBytes = await ReportPdfService.buildPdfData(
        salesCtrl: salesController,
        expenseCtrl: expenseController,
        productCtrl: productController,
      );

      Get.back();

      if (isPrint) {
        await ReportPdfService.printPdf(pdfBytes);
      } else {
        String path = await ReportPdfService.downloadPdf(pdfBytes);
        Get.snackbar(
          "Success",
          "Report downloaded to: $path",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error",
        "Could not generate PDF: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
