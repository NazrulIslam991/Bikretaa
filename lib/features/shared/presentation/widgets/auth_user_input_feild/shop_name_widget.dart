import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
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
    final r = Responsive.of(context);

    return SizedBox(
      height: r.height(0.06), // responsive height
      child: TextFormField(
        controller: _shopNameEcontroller,
        style: TextStyle(
          fontSize: r.fontMedium(),
          color: theme.colorScheme.onBackground,
        ),
        decoration: InputDecoration(
          hintText: 'Shop_Name'.tr,
          labelText: 'Shop_Name'.tr,

          hintStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: theme.colorScheme.primary,
            letterSpacing: 0.4,
            fontSize: r.fontMedium(),
          ),
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: theme.colorScheme.primary,
            letterSpacing: 0.4,
            fontSize: r.fontMedium(),
          ),
          prefixIcon: Icon(
            Icons.shopping_bag,
            color: Colors.blue,
            size: r.iconMedium(),
          ),
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
