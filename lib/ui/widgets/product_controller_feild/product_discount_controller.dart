import 'package:flutter/material.dart';

class ProductDiscountController extends StatelessWidget {
  const ProductDiscountController({
    super.key,
    required TextEditingController productDiscountController,
  }) : _productDiscountController = productDiscountController;

  final TextEditingController _productDiscountController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _productDiscountController,
      decoration: InputDecoration(hintText: "Discount", labelText: "Discount"),
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        String shop_name = value ?? '';
        if (shop_name.isEmpty) {
          return 'Discount is required';
        }
        return null;
      },
    );
  }
}
