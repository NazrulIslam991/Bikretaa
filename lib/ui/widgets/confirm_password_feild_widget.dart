import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmPasswordFeildWidget extends StatelessWidget {
  const ConfirmPasswordFeildWidget({
    super.key,
    required TextEditingController passwordEcontroller,
    required TextEditingController confirmpasswordEcontroller,
  }) : _confirmpasswordEcontroller = confirmpasswordEcontroller,
       _passwordEcontroller = passwordEcontroller;

  final TextEditingController _confirmpasswordEcontroller;
  final TextEditingController _passwordEcontroller;
  bool validateCPassword(String cPassword) {
    String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(cPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _confirmpasswordEcontroller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: "Confirm Password",
          labelText: "Confirm Password",
          hintStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            letterSpacing: 0.4,
            fontSize: 12.h,
          ),
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.grey.shade700,
            letterSpacing: 0.4,
            fontSize: 12.h,
          ),
          prefixIcon: Icon(Icons.lock, color: Colors.blue, size: 20.sp),
          suffixIcon: Icon(
            Icons.remove_red_eye,
            color: Colors.blue,
            size: 20.sp,
          ),
        ),
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Password';
          } else if (value != _passwordEcontroller.text) {
            return 'Passwords do not match';
          } else if (!validateCPassword(value)) {
            return "Password must be 8+ chars with uppercase, lowercase & special char.";
          }
          return null;
        },
      ),
    );
  }
}
