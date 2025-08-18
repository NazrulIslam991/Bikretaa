import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerAddressController extends StatelessWidget {
  const CustomerAddressController({
    super.key,
    required TextEditingController CustomerAddressController,
  }) : _CustomerAddressController = CustomerAddressController;

  final TextEditingController _CustomerAddressController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _CustomerAddressController,
        decoration: InputDecoration(
          hintText: "Address",
          labelText: "Address",
          prefixIcon: Icon(Icons.location_on_outlined, color: Colors.blue),
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
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          String shop_name = value ?? '';
          if (shop_name.isEmpty) {
            return 'Address is required';
          }
          return null;
        },
      ),
    );
  }
}
