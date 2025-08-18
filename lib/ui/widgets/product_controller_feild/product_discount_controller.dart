import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDiscountController extends StatelessWidget {
  const ProductDiscountController({
    super.key,
    required TextEditingController productDiscountController,
  }) : _productDiscountController = productDiscountController;

  final TextEditingController _productDiscountController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _productDiscountController,
        decoration: InputDecoration(
          hintText: "Discount",
          labelText: "Discount",
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
            return 'Discount is required';
          }
          return null;
        },
      ),
    );
  }
}
