import 'package:flutter/material.dart';

class EmailFeildWidget extends StatelessWidget {
  const EmailFeildWidget({
    super.key,
    required TextEditingController emailEcontroller,
  }) : _emailEcontroller = emailEcontroller;

  final TextEditingController _emailEcontroller;
  bool validateEmail(String email) {
    String pattern =
        r'^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9]+)*@(gmail|yahoo)\.com$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailEcontroller,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Email",
        prefixIcon: Icon(Icons.email, color: Colors.blue),
      ),
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email address';
        } else if (!validateEmail(value)) {
          return 'Please enter a valid email address';
        }
        return null; // Input is valid
      },
      autofillHints: [AutofillHints.email],
    );
  }
}
