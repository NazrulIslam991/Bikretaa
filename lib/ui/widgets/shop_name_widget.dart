import 'package:flutter/material.dart';

class ShopNameWidget extends StatelessWidget {
  const ShopNameWidget({
    super.key,
    required TextEditingController shopNameEcontroller,
  }) : _shopNameEcontroller = shopNameEcontroller;

  final TextEditingController _shopNameEcontroller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _shopNameEcontroller,
      decoration: InputDecoration(
        hintText: "Shop Name",
        labelText: "Shop Name",
        prefixIcon: Icon(Icons.shopping_bag, color: Colors.blue),
      ),
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        String shop_name = value ?? '';
        if (shop_name.isEmpty) {
          return 'Shop name is required';
        }
        return null;
      },
    );
  }
}
