import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductIdController extends StatelessWidget {
  const ProductIdController({
    super.key,
    required TextEditingController productIdController,
    this.readOnly = false,
  }) : _productIdController = productIdController;

  final TextEditingController _productIdController;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _productIdController,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: "Product id",
          labelText: "Product id",
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
          String productId = value ?? '';
          if (productId.isEmpty) {
            return 'Product id is required';
          }
          return null;
        },
      ),
    );
  }
}
