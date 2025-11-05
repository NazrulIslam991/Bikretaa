import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

typedef OnRemoveProduct = void Function(int index);

class ProductsListWidget extends StatelessWidget {
  final List<Map<String, String>> products;
  final OnRemoveProduct onRemoveProduct;

  const ProductsListWidget({
    Key? key,
    required this.products,
    required this.onRemoveProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: products.isEmpty
          ? Center(child: Text("no_products_added".tr))
          : Padding(
              padding: const EdgeInsets.only(
                right: 10,
                left: 10,
                top: 5,
                bottom: 5,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) =>
                          _buildProductCard(context, index),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(8.h),
                    child: Text(
                      "${"grand_total".tr}: ${_grandTotal().toStringAsFixed(2)} tk",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildProductCard(BuildContext context, int index) {
    final theme = Theme.of(context);
    final item = products[index];
    return Card(
      color: theme.cardColor,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: BorderSide(color: theme.colorScheme.primary, width: 0.5),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey.shade50,
          child: Text(
            item['quantity'] ?? "0",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
        title: Text(
          item['productName'] ?? "",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: theme.colorScheme.primary,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          "${"unit_price".tr}: ${item['unitPrice']} tk\n${"total".tr}: ${item['totalPrice']} tk",
          style: TextStyle(fontSize: 12, color: theme.colorScheme.primary),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => onRemoveProduct(index),
        ),
      ),
    );
  }

  double _grandTotal() {
    double total = 0;
    for (var item in products) {
      total += double.tryParse(item['totalPrice'] ?? "0") ?? 0;
    }
    return total;
  }
}
