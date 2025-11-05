import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConfirmPasswordFeildWidget extends StatefulWidget {
  const ConfirmPasswordFeildWidget({
    super.key,
    required TextEditingController passwordEcontroller,
    required TextEditingController confirmpasswordEcontroller,
  }) : _confirmpasswordEcontroller = confirmpasswordEcontroller,
       _passwordEcontroller = passwordEcontroller;

  final TextEditingController _confirmpasswordEcontroller;
  final TextEditingController _passwordEcontroller;

  @override
  State<ConfirmPasswordFeildWidget> createState() =>
      _ConfirmPasswordFeildWidgetState();
}

class _ConfirmPasswordFeildWidgetState
    extends State<ConfirmPasswordFeildWidget> {
  bool validateCPassword(String cPassword) {
    String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(cPassword);
  }

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: widget._confirmpasswordEcontroller,
        obscureText: _obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: 'Confirm_Password'.tr,
          labelText: 'Confirm_Password'.tr,
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
          prefixIcon: Icon(Icons.lock, color: Colors.blue, size: 20.sp),
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please_enter_Password'.tr;
          } else if (value != widget._passwordEcontroller.text) {
            return 'Passwords_do_not_match'.tr;
          } else if (!validateCPassword(value)) {
            return 'Password_hints'.tr;
          }
          return null;
        },
      ),
    );
  }
}
