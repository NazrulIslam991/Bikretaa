import 'package:flutter/material.dart';

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
    return TextFormField(
      controller: _passwordEcontroller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: "Password",
        labelText: "Password",
        prefixIcon: Icon(Icons.lock, color: Colors.blue),
        suffixIcon: Icon(Icons.remove_red_eye, color: Colors.blue),
      ),
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Password';
        } else if (!validatePassword(value)) {
          return 'Password must be at least 8 characters long and include:\n- 1 uppercase letter\n- 1 lowercase letter\n- 1 special character (! @ # \$ & * ~)';
        }
        return null; // Input is valid
      },
    );
  }
}
