import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductNameController extends StatelessWidget {
  const ProductNameController({
    super.key,
    required TextEditingController ProductNameController,
  }) : _ProductNameController = ProductNameController;

  final TextEditingController _ProductNameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _ProductNameController,
        decoration: InputDecoration(
          hintText: "Product Name",
          labelText: "Product Name",
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.grey.shade700,
            letterSpacing: 0.4,
            fontSize: 12.h,
          ),
          hintStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            letterSpacing: 0.4,
            fontSize: 12.h,
          ),
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
      ),
    );
  }
}
