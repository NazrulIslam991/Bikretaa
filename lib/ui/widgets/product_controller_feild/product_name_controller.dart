import 'package:flutter/material.dart';

class ProductNameController extends StatelessWidget {
  const ProductNameController({
    super.key,
    required TextEditingController ProductNameController,
  }) : _ProductNameController = ProductNameController;

  final TextEditingController _ProductNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _ProductNameController,
      decoration: InputDecoration(
        hintText: "Product Name",
        labelText: "Product Name",
      ),
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        String shop_name = value ?? '';
        if (shop_name.isEmpty) {
          return 'Product Name is required';
        }
        return null;
      },
    );
  }
}
