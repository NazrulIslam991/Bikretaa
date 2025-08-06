import 'package:flutter/material.dart';

class ProductQuantityController extends StatelessWidget {
  const ProductQuantityController({
    super.key,
    required TextEditingController productQuantityController,
  }) : _productQuantityController = productQuantityController;

  final TextEditingController _productQuantityController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _productQuantityController,
      decoration: InputDecoration(
        hintText: "Product Quantity",
        labelText: "Product Quantity",
      ),
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        String shop_name = value ?? '';
        if (shop_name.isEmpty) {
          return 'Product Quantity is required';
        }
        return null;
      },
    );
  }
}
