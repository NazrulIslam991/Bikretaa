import 'package:bikretaa/features/products/screens/add_product_screen.dart';
import 'package:bikretaa/features/products/screens/products_screen.dart';
import 'package:bikretaa/features/sales/screens/add_sales_screen.dart';
import 'package:bikretaa/features/sales/screens/due_collection_screen.dart';
import 'package:flutter/material.dart';

Widget getQuickActionScreenByTitle(String title) {
  switch (title) {
    case "Add Product":
      return AddProductScreen();
    case "Record Sale":
      return AddSalesScreen();
    case "Due Collection":
      return DueCollectionScreen();
    case "All Products":
      return ProductsScreen();
    // Add your remaining Quick Actions screens when implemented
    // case "Low Stock": return LowStockScreen();
    // case "Stock Adjust": return StockAdjustScreen();
    // case "Expired Date": return ExpiredDateScreen();
    // case "Expire Soon": return ExpireSoonScreen();
    // case "Last Week Sales": return LastWeekSalesScreen();
    // case "Last Month Sales": return LastMonthSalesScreen();
    default:
      return Scaffold(body: Center(child: Text("Screen not found")));
  }
}
