import 'package:flutter/material.dart';

class ProductPurchasePrice extends StatelessWidget {
  const ProductPurchasePrice({
    super.key,
    required TextEditingController ProductPurchasePrice,
  }) : _ProductPurchasePrice = ProductPurchasePrice;

  final TextEditingController _ProductPurchasePrice;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _ProductPurchasePrice,
      decoration: InputDecoration(
        hintText: "Purchase Price",
        labelText: "Purchase Price",
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
    );
  }
}
