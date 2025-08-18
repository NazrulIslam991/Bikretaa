import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductBrandController extends StatelessWidget {
  const ProductBrandController({
    super.key,
    required TextEditingController productBandNameController,
  }) : _productBandNameController = productBandNameController;

  final TextEditingController _productBandNameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _productBandNameController,
        decoration: InputDecoration(
          hintText: "Product Brand",
          labelText: "Product Brand",
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
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          String shop_name = value ?? '';
          if (shop_name.isEmpty) {
            return 'Brand name is required';
          }
          return null;
        },
      ),
    );
  }
}
