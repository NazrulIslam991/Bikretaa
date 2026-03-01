import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDescriptionController extends StatelessWidget {
  const ProductDescriptionController({
    super.key,
    required TextEditingController productDescriptionController,
  }) : _productDescriptionController = productDescriptionController;

  final TextEditingController _productDescriptionController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 150,
      child: Container(
        height: 45.h,
        child: TextFormField(
          controller: _productDescriptionController,
          decoration: InputDecoration(
            hintText: "product_description_hint".tr,
            labelText: "product_description".tr,

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
            border: OutlineInputBorder(),
            alignLabelWithHint: true,
          ),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          minLines: 5,
          textInputAction: TextInputAction.newline,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            String shop_name = value ?? '';
            if (shop_name.isEmpty) {
              return 'product_description_required'.tr;
            }
            return null;
          },
        ),
      ),
    );
  }
}
