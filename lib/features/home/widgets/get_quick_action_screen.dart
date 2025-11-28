import 'package:flutter/material.dart';

import '../../products/screens/add_product_screen.dart';
import '../../products/screens/homepage_product_list.dart';
import '../../sales/screens/add_sales_screen.dart';
import '../../sales/screens/customer_list_screen.dart';
import '../../sales/screens/due_collection_screen.dart';
import '../../sales/screens/homepage_sales_page.dart';

Widget getQuickActionScreenByTitle(String title) {
  switch (title) {
    case "Add Product":
      return AddProductScreen();
    case "Record Sale":
      return AddSalesScreen();
    case "Due Collection":
      return DueCollectionScreen();

    // Product-related filters
    case "All Products":
      return ProductsFilterScreen(title: title);
    case "Low Stock":
      return ProductsFilterScreen(title: title);
    case "Expired Date":
      return ProductsFilterScreen(title: title);
    case "Expire Soon":
      return ProductsFilterScreen(title: title);
    case "Out of Stock":
      return ProductsFilterScreen(title: title);
    // Sales summary charts
    case "Last Month Sales":
    case "Last Week Sales":
      return SalesSummaryScreen(title: title);
    case "Customer Lists":
      return CustomerListScreen(title: title);

    // case "Stock Adjust":
    //   return StockAdjustScreen();

    default:
      return Scaffold(
        body: Center(child: Text("Screen not found for '$title'")),
      );
  }
}
