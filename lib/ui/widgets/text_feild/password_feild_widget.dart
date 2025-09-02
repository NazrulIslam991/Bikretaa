import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordFeildWidget extends StatefulWidget {
  const PasswordFeildWidget({
    super.key,
    required TextEditingController passwordEcontroller,
  }) : _passwordEcontroller = passwordEcontroller;

  final TextEditingController _passwordEcontroller;

  @override
  State<PasswordFeildWidget> createState() => _PasswordFeildWidgetState();
}

class _PasswordFeildWidgetState extends State<PasswordFeildWidget> {
  bool validatePassword(String password) {
    String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: TextFormField(
        controller: widget._passwordEcontroller,
        obscureText: _obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: theme.colorScheme.primary,
            letterSpacing: 0.4,
            fontSize: 12.h,
          ),
          labelText: "Password",
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
