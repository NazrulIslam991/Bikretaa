import 'package:flutter/material.dart';

class ProductExpireDateController extends StatelessWidget {
  const ProductExpireDateController({
    super.key,
    required TextEditingController ProductExpireDateController,
  }) : _ProductExpireDateController = ProductExpireDateController;

  final TextEditingController _ProductExpireDateController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _ProductExpireDateController,
      decoration: InputDecoration(
        hintText: "Expire Date",
        labelText: "Expire Date",
      ),
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        String shop_name = value ?? '';
        if (shop_name.isEmpty) {
          return 'Expire date  is required';
        }
        return null;
      },
    );
  }
}
