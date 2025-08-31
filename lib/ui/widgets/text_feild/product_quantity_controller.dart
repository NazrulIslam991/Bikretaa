import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductQuantityController extends StatelessWidget {
  const ProductQuantityController({
    super.key,
    required TextEditingController productQuantityController,
  }) : _productQuantityController = productQuantityController;

  final TextEditingController _productQuantityController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _productQuantityController,
        decoration: InputDecoration(
          hintText: "Product Quantity",
          labelText: "Product Quantity",
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
            return 'Product Quantity is required';
          }
          return null;
        },
      ),
    );
  }
}
