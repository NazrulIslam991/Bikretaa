import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            hintText: "Product Description",
            labelText: "Product Description",
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
              return 'Product Description is required';
            }
            return null;
          },
        ),
      ),
    );
  }
}
