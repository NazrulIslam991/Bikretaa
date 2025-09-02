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
    final theme = Theme.of(context);
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _productQuantityController,
        decoration: InputDecoration(
          hintText: "Enter product quantity",
          labelText: "Product Quantity",
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: theme.colorScheme.primary,
            letterSpacing: 0.4,
            fontSize: 12.h,
          ),
          hintStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.grey,
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
