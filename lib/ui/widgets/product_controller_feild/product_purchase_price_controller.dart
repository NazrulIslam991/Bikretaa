import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductPurchasePrice extends StatelessWidget {
  const ProductPurchasePrice({
    super.key,
    required TextEditingController ProductPurchasePrice,
  }) : _ProductPurchasePrice = ProductPurchasePrice;

  final TextEditingController _ProductPurchasePrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _ProductPurchasePrice,
        decoration: InputDecoration(
          hintText: "Purchase Price",
          labelText: "Purchase Price",
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.grey.shade700,
            letterSpacing: 0.4,
            fontSize: 12.h,
          ),
          hintStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            letterSpacing: 0.4,
            fontSize: 12.h,
          ),
        ),
        textInputAction: TextInputAction.next,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          String shop_name = value ?? '';
          if (shop_name.isEmpty) {
            return 'Purchase Price is required';
          }
          return null;
        },
      ),
    );
  }
}
