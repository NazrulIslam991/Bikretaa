import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductManufactureDateController extends StatelessWidget {
  const ProductManufactureDateController({
    super.key,
    required TextEditingController productManufactureDateController,
  }) : _productManufactureDateController = productManufactureDateController;

  final TextEditingController _productManufactureDateController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _productManufactureDateController,
        decoration: InputDecoration(
          hintText: "Manufacture Date",
          labelText: "Manufacture Date",
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
            return 'Manufacture date  is required';
          }
          return null;
        },
      ),
    );
  }
}
