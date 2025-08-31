import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerNameController extends StatelessWidget {
  const CustomerNameController({
    super.key,
    required TextEditingController CustomerNameController,
  }) : _CustomerNameController = CustomerNameController;

  final TextEditingController _CustomerNameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _CustomerNameController,
        decoration: InputDecoration(
          hintText: "Customer Name",
          labelText: "Customer Name",
          prefixIcon: Icon(Icons.person, color: Colors.blue),
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
            return 'Customer Name is required';
          }
          return null;
        },
      ),
    );
  }
}
