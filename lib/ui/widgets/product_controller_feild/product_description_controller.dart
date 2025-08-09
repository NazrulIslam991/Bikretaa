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
            border: OutlineInputBorder(),
            alignLabelWithHint: true, // aligns label at the top when multiline
          ),
          keyboardType: TextInputType.multiline,
          maxLines: null, // makes it expandable if needed
          minLines: 5, // ensures it's at least 5 lines tall
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
