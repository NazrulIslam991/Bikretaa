import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductBarCodeController extends StatelessWidget {
  const ProductBarCodeController({
    super.key,
    required TextEditingController productBarCodeController,
  }) : _productBarCodeController = productBarCodeController;

  final TextEditingController _productBarCodeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _productBarCodeController,
        decoration: InputDecoration(
          hintText: "Bar Code No",
          labelText: "Bar Code NO",
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
            return 'Bar Code no is required';
          }
          return null;
        },
      ),
    );
  }
}
