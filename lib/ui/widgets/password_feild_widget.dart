import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordFeildWidget extends StatelessWidget {
  const PasswordFeildWidget({
    super.key,
    required TextEditingController passwordEcontroller,
  }) : _passwordEcontroller = passwordEcontroller;

  final TextEditingController _passwordEcontroller;
  bool validatePassword(String password) {
    String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _passwordEcontroller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            letterSpacing: 0.4,
            fontSize: 12.h,
          ),
          labelText: "Password",
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
          } else if (!validatePassword(value)) {
            return "Password must be 8+ chars with uppercase, lowercase & special char.";
          }
          return null;
        },
      ),
    );
  }
}
