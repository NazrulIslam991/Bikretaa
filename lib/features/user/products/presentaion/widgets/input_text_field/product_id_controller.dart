import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductIdController extends StatelessWidget {
  const ProductIdController({
    super.key,
    required TextEditingController productIdController,
    this.readOnly = false,
  }) : _productIdController = productIdController;

  final TextEditingController _productIdController;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _productIdController,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: "enter_product_id".tr,
          labelText: "product_id".tr,
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
          String productId = value ?? '';
          if (productId.isEmpty) {
            return 'product_id_required'.tr;
          }
          return null;
        },
      ),
    );
  }
}
