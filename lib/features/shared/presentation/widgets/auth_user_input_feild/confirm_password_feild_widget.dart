import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
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
  bool _obscureText = true;

  bool validateCPassword(String cPassword) {
    String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(cPassword);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return SizedBox(
      height: r.height(0.06),
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
            fontSize: r.fontMedium(),
          ),
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
