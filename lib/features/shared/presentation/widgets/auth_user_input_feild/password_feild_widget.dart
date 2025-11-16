import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    final r = Responsive.of(context); // Responsive instance

    return Container(
      height: r.height(0.06),
      child: TextFormField(
        controller: widget._passwordEcontroller,
        obscureText: _obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: 'Password'.tr,
          hintStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: theme.colorScheme.primary,
            letterSpacing: 0.4,
            fontSize: r.fontMedium(),
          ),
          labelText: 'Password'.tr,
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: theme.colorScheme.primary,
            letterSpacing: 0.4,
            fontSize: r.fontMedium(),
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.blue,
            size: r.iconMedium(),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              size: r.iconMedium(),
            ),
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
          } else if (!validatePassword(value)) {
            return 'Password_hints'.tr;
          }
          return null;
        },
      ),
    );
  }
}
