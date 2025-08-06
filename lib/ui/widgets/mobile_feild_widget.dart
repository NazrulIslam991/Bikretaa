import 'package:flutter/material.dart';

class MobileFeildWidget extends StatelessWidget {
  const MobileFeildWidget({
    super.key,
    required TextEditingController mobileEcontroller,
  }) : _mobileEcontroller = mobileEcontroller;

  final TextEditingController _mobileEcontroller;
  bool validatePhone(String phone) {
    String pattern = r'^(?:\+8801|01)[3-9]\d{8}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _mobileEcontroller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: "Phone Number",
        labelText: "Phone Number",
        prefixIcon: Icon(Icons.phone, color: Colors.blue),
      ),
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter phone number';
        } else if (!validatePhone(value)) {
          return 'Please enter a valid phone number';
        }
        return null; // Input is valid
      },
    );
  }
}
