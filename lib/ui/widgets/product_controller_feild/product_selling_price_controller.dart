import 'package:flutter/material.dart';

class ProductSellingPriceController extends StatelessWidget {
  const ProductSellingPriceController({
    super.key,
    required TextEditingController ProductSellingPriceController,
  }) : _ProductSellingPriceController = ProductSellingPriceController;

  final TextEditingController _ProductSellingPriceController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _ProductSellingPriceController,
      decoration: InputDecoration(
        hintText: "Selling Price",
        labelText: "Selling Price",
      ),
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        String shop_name = value ?? '';
        if (shop_name.isEmpty) {
          return 'Selling Price is required';
        }
        return null;
      },
    );
  }
}
