import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductNameController extends StatelessWidget {
  const ProductNameController({
    super.key,
    required TextEditingController ProductNameController,
  }) : _ProductNameController = ProductNameController;

  final TextEditingController _ProductNameController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _ProductNameController,
        decoration: InputDecoration(
          hintText: "product_name_hint".tr,
          labelText: "product_name_label".tr,

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
            return 'product_name_required'.tr;
          }
          return null;
        },
      ),
    );
  }
}
