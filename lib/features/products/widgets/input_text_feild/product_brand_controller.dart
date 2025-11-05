import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductBrandController extends StatelessWidget {
  const ProductBrandController({
    super.key,
    required TextEditingController productBandNameController,
  }) : _productBandNameController = productBandNameController;

  final TextEditingController _productBandNameController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _productBandNameController,
        decoration: InputDecoration(
          hintText: "enter_product_brand".tr,
          labelText: "product_brand".tr,
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: theme.colorScheme.primary,
            letterSpacing: 0.4,
            fontSize: 12.h,
          ),
          hintStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.grey,
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
            return "brand_name_required".tr;
          }
          return null;
        },
      ),
    );
  }
}
