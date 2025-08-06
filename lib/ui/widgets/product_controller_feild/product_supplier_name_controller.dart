import 'package:flutter/material.dart';

class ProductSupplierNameController extends StatelessWidget {
  const ProductSupplierNameController({
    super.key,
    required TextEditingController productSupplierNameController,
  }) : _productSupplierNameController = productSupplierNameController;

  final TextEditingController _productSupplierNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _productSupplierNameController,
      decoration: InputDecoration(
        hintText: "Supplier Name",
        labelText: "Supplier Name",
      ),
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        String shop_name = value ?? '';
        if (shop_name.isEmpty) {
          return 'Supplier name is required';
        }
        return null;
      },
    );
  }
}
