import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductSupplierNameController extends StatelessWidget {
  const ProductSupplierNameController({
    super.key,
    required TextEditingController productSupplierNameController,
  }) : _productSupplierNameController = productSupplierNameController;

  final TextEditingController _productSupplierNameController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _productSupplierNameController,
        decoration: InputDecoration(
          hintText: "enter_supplier_name".tr,
          labelText: "supplier_name".tr,
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
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          String shop_name = value ?? '';
          if (shop_name.isEmpty) {
            return 'supplier_name_required'.tr;
          }
          return null;
        },
      ),
    );
  }
}
