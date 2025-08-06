import 'package:flutter/material.dart';

class ProductBrandController extends StatelessWidget {
  const ProductBrandController({
    super.key,
    required TextEditingController productBandNameController,
  }) : _productBandNameController = productBandNameController;

  final TextEditingController _productBandNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _productBandNameController,
      decoration: InputDecoration(
        hintText: "Product Brand",
        labelText: "Product Brand",
      ),
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        String shop_name = value ?? '';
        if (shop_name.isEmpty) {
          return 'Brand name is required';
        }
        return null;
      },
    );
  }
}
