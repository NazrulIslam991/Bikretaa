import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardWidget extends StatelessWidget {
  final Map<String, String> item;
  final VoidCallback onRemove;

  const ProductCardWidget({
    super.key,
    required this.item,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
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
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          "Unit: ${item['unitPrice']} tk\nTotal: ${item['totalPrice']} tk",
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
