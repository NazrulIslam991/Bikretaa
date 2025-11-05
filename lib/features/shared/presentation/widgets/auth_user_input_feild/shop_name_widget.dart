import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShopNameWidget extends StatelessWidget {
  const ShopNameWidget({
    super.key,
    required TextEditingController shopNameEcontroller,
  }) : _shopNameEcontroller = shopNameEcontroller;

  final TextEditingController _shopNameEcontroller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _shopNameEcontroller,
        decoration: InputDecoration(
          hintText: 'Shop_Name'.tr,
          labelText: 'Shop_Name'.tr,
          hintStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: theme.colorScheme.primary,
            letterSpacing: 0.4,
            fontSize: 12.h,
          ),
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: theme.colorScheme.primary,
            letterSpacing: 0.4,
            fontSize: 12.h,
          ),
          prefixIcon: Icon(Icons.shopping_bag, color: Colors.blue, size: 20.sp),
        ),
        textInputAction: TextInputAction.next,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          String shop_name = value ?? '';
          if (shop_name.isEmpty) {
            return 'Shop_name_is_required'.tr;
          }
          return null;
        },
      ),
    );
  }
}
