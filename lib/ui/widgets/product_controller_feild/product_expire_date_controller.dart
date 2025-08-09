import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductExpireDateController extends StatelessWidget {
  const ProductExpireDateController({
    super.key,
    required TextEditingController ProductExpireDateController,
  }) : _ProductExpireDateController = ProductExpireDateController;

  final TextEditingController _ProductExpireDateController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _ProductExpireDateController,
        decoration: InputDecoration(
          hintText: "Expire Date",
          labelText: "Expire Date",
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
            return 'Expire date  is required';
          }
          return null;
        },
      ),
    );
  }
}
