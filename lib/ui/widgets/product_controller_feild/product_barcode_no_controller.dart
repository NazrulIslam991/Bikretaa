import 'package:flutter/material.dart';

class ProductBarCodeController extends StatelessWidget {
  const ProductBarCodeController({
    super.key,
    required TextEditingController productBarCodeController,
  }) : _productBarCodeController = productBarCodeController;

  final TextEditingController _productBarCodeController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _productBarCodeController,
      decoration: InputDecoration(
        hintText: "Bar Code No",
        labelText: "Bar Code NO",
      ),
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        String shop_name = value ?? '';
        if (shop_name.isEmpty) {
          return 'Bar Code no is required';
        }
        return null;
      },
    );
  }
}
