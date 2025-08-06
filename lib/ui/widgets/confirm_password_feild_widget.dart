import 'package:flutter/material.dart';

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
    return TextFormField(
      controller: _confirmpasswordEcontroller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: "Confirm Password",
        labelText: "Confirm Password",
        prefixIcon: Icon(Icons.lock, color: Colors.blue),
        suffixIcon: Icon(Icons.remove_red_eye, color: Colors.blue),
      ),
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Password';
        } else if (value != _passwordEcontroller.text) {
          return 'Passwords do not match';
        } else if (!validateCPassword(value)) {
          return 'Password must be at least 8 characters long and include:\n- 1 uppercase letter\n- 1 lowercase letter\n- 1 special character (! @ # \$ & * ~)';
        }
        return null; // Input is valid
      },
    );
  }
}
