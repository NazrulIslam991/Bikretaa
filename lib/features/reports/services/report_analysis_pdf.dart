import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../app/controller/expense_report_controller.dart';
import '../../../app/controller/product_controller/product_controller.dart';
import '../../../app/controller/sales_report_controller.dart';
import '../../../assets_path/assets_path.dart';
import '../models/chart_data/chart_data.dart';
import 'pdf_widgets_helper.dart';

class ReportPdfService {
  static Future<Uint8List> buildPdfData({
    required SalesReportController salesCtrl,
    required ExpenseReportController expenseCtrl,
    required ProductController productCtrl,
  }) async {
    final pdf = pw.Document();
    final now = DateTime.now();
    final dateStr = DateFormat('dd MMM yyyy, hh:mm a').format(now);

    final ByteData logoData = await rootBundle.load(AssetPaths.logo);
    final pw.MemoryImage logoImage = pw.MemoryImage(
      logoData.buffer.asUint8List(),
    );

    final List<String> allRanges = ["Today", "Days", "Weeks", "Months"];

    for (String range in allRanges) {
      String dynamicName = _getDynamicName(range, now);

      final List<ChartData> salesData = await salesCtrl.fetchSalesDataSilent(
        range,
      );
      final Map<String, dynamic> expenseData = await expenseCtrl
          .fetchProductEntryCostSilent(range);

      double totalSales = salesData.fold(0, (sum, item) => sum + item.sales);
      double totalRevenue = salesData.fold(
        0,
        (sum, item) => sum + item.revenue,
      );
      double totalDue = salesData.fold(0, (sum, item) => sum + item.due);
      double trend = salesCtrl.calculateTrendSilent(salesData);

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          header: (context) =>
              PdfWidgetsHelper.buildHeader(dateStr, dynamicName, logoImage),
          build: (context) => [
            PdfWidgetsHelper.sectionTitle(
              "1. Sales & Profit Performance ($dynamicName)",
            ),
            PdfWidgetsHelper.statRow([
              {
                "title": "Total Sales",
                "val": "TK ${totalSales.toStringAsFixed(2)}",
                "color": PdfColors.blue700,
              },
              {
                "title": "Net Profit",
                "val": "TK ${totalRevenue.toStringAsFixed(2)}",
                "color": PdfColors.green700,
              },
              {
                "title": "Trend",
                "val": "${trend.toStringAsFixed(1)}%",
                "color": trend >= 0 ? PdfColors.green700 : PdfColors.red700,
              },
            ]),
            pw.SizedBox(height: 10),
            PdfWidgetsHelper.analysisBox(
              "Sales Trend ($dynamicName): Business saw ${trend >= 0 ? 'growth' : 'decline'} of ${trend.abs().toStringAsFixed(1)}%. Total: TK ${totalSales.toStringAsFixed(2)}.",
            ),

            pw.SizedBox(height: 20),
            PdfWidgetsHelper.sectionTitle("2. Inventory Health Status"),
            PdfWidgetsHelper.inventoryTable(productCtrl),

            pw.SizedBox(height: 20),
            PdfWidgetsHelper.sectionTitle(
              "3. Stock Entry Analysis ($dynamicName)",
            ),
            PdfWidgetsHelper.statRow([
              {
                "title": "Items Added",
                "val": "${expenseData['totalQty']}",
                "color": PdfColors.purple700,
              },
              {
                "title": "SKUs",
                "val": "${expenseData['uniqueCount']}",
                "color": PdfColors.cyan700,
              },
              {
                "title": "Total Due",
                "val": "TK ${totalDue.toStringAsFixed(2)}",
                "color": PdfColors.red700,
              },
            ]),
            pw.SizedBox(height: 20),
            PdfWidgetsHelper.sectionTitle("Detailed Data Logs"),
            PdfWidgetsHelper.logsTable(salesData),
          ],
        ),
      );
    }
    return pdf.save();
  }

  static String _getDynamicName(String range, DateTime now) {
    if (range == "Today") return DateFormat('EEEE').format(now);
    if (range == "Days") return "Last 7 Days";
    if (range == "Weeks") return "Last Month";
    if (range == "Months") return "This Year";
    return range;
  }

  static Future<void> printPdf(Uint8List data) async {
    await Printing.layoutPdf(
      onLayout: (format) async => data,
      name: 'Bikretaa_Report',
    );
  }

  static Future<String> downloadPdf(Uint8List data) async {
    Directory? downloadDir = Platform.isAndroid
        ? Directory('/storage/emulated/0/Download')
        : await getApplicationDocumentsDirectory();

    if (Platform.isAndroid && !await downloadDir.exists()) {
      downloadDir = await getExternalStorageDirectory();
    }

    final file = File(
      "${downloadDir!.path}/Bikretaa_Report_${DateTime.now().millisecondsSinceEpoch}.pdf",
    );
    await file.writeAsBytes(data);
    return file.path;
  }
}
