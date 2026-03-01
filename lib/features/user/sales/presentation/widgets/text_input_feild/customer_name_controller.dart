import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerNameController extends StatelessWidget {
  const CustomerNameController({
    super.key,
    required TextEditingController CustomerNameController,
  }) : _CustomerNameController = CustomerNameController;

  final TextEditingController _CustomerNameController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _CustomerNameController,
        decoration: InputDecoration(
          hintText: "customer_name_hint".tr,
          labelText: "customer_name_label".tr,
          prefixIcon: Icon(Icons.person, color: Colors.blue),
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
            return "customer_name_required".tr;
          }
          return null;
        },
      ),
    );
  }
}
