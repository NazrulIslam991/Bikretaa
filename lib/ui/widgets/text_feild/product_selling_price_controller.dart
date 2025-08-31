import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSellingPriceController extends StatelessWidget {
  const ProductSellingPriceController({
    super.key,
    required TextEditingController ProductSellingPriceController,
  }) : _ProductSellingPriceController = ProductSellingPriceController;

  final TextEditingController _ProductSellingPriceController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _ProductSellingPriceController,
        decoration: InputDecoration(
          hintText: "Selling Price",
          labelText: "Selling Price",
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
        keyboardType: TextInputType.number,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          String shop_name = value ?? '';
          if (shop_name.isEmpty) {
            return 'Selling Price is required';
          }
          return null;
        },
      ),
    );
  }
}
