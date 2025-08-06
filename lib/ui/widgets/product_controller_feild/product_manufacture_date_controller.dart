import 'package:flutter/material.dart';

class ProductManufactureDateController extends StatelessWidget {
  const ProductManufactureDateController({
    super.key,
    required TextEditingController productManufactureDateController,
  }) : _productManufactureDateController = productManufactureDateController;

  final TextEditingController _productManufactureDateController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _productManufactureDateController,
      decoration: InputDecoration(
        hintText: "Manufacture Date",
        labelText: "Manufacture Date",
      ),
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        String shop_name = value ?? '';
        if (shop_name.isEmpty) {
          return 'Manufacture date  is required';
        }
        return null;
      },
    );
  }
}
