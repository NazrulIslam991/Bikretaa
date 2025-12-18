import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../app/controller/product_controller/product_controller.dart';
import '../models/chart_data/chart_data.dart';

class PdfWidgetsHelper {
  static pw.Widget buildHeader(String date, String range, pw.MemoryImage logo) {
    return pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "BIKRETAA - BUSINESS REPORT",
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue900,
                  ),
                ),
                pw.Text(
                  "$range Analysis",
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.Text(
                  "Generated: $date",
                  style: const pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.grey700,
                  ),
                ),
              ],
            ),
            pw.Container(height: 50, width: 50, child: pw.Image(logo)),
          ],
        ),
        pw.SizedBox(height: 5),
        pw.Divider(thickness: 1, color: PdfColors.blueGrey100),
        pw.SizedBox(height: 10),
      ],
    );
  }

  static pw.Widget sectionTitle(String title) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 8),
    child: pw.Text(
      title,
      style: pw.TextStyle(
        fontSize: 12,
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.blueGrey800,
      ),
    ),
  );

  static pw.Widget statRow(List<Map<String, dynamic>> stats) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: stats
          .map((s) => _statBox(s['title'], s['val'], s['color']))
          .toList(),
    );
  }

  static pw.Widget _statBox(String title, String value, PdfColor color) =>
      pw.Container(
        width: 150,
        padding: const pw.EdgeInsets.all(6),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: color, width: 0.5),
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
        ),
        child: pw.Column(
          children: [
            pw.Text(
              title,
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700),
            ),
            pw.Text(
              value,
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      );

  static pw.Widget analysisBox(String text) => pw.Container(
    width: double.infinity,
    padding: const pw.EdgeInsets.all(8),
    decoration: const pw.BoxDecoration(color: PdfColors.blue50),
    child: pw.Text(text, style: const pw.TextStyle(fontSize: 9)),
  );

  static pw.Widget inventoryTable(ProductController productCtrl) {
    return pw.TableHelper.fromTextArray(
      headers: ['Total SKU', 'In Stock', 'Low Stock', 'Out of Stock'],
      data: [
        [
          productCtrl.allProducts.length.toString(),
          (productCtrl.allProducts.length -
                  productCtrl.outOfStockProducts.length)
              .toString(),
          productCtrl.lowStockProducts.length.toString(),
          productCtrl.outOfStockProducts.length.toString(),
        ],
      ],
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.white,
        fontSize: 10,
      ),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.blueGrey700),
      cellAlignment: pw.Alignment.center,
      cellStyle: const pw.TextStyle(fontSize: 9),
    );
  }

  static pw.Widget logsTable(List<ChartData> data) {
    return pw.TableHelper.fromTextArray(
      headers: ['Period', 'Sales', 'Profit', 'Due'],
      data: data
          .map(
            (d) => [
              d.x,
              d.sales.toStringAsFixed(1),
              d.revenue.toStringAsFixed(1),
              d.due.toStringAsFixed(1),
            ],
          )
          .toList(),
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.white,
        fontSize: 10,
      ),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.blueGrey900),
      cellAlignment: pw.Alignment.centerRight,
      cellAlignments: {0: pw.Alignment.centerLeft},
      cellStyle: const pw.TextStyle(fontSize: 8),
    );
  }
}
