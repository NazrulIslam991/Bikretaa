import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailFeildWidget extends StatelessWidget {
  final TextEditingController _emailEcontroller;
  final String? emailText;

  EmailFeildWidget({
    super.key,
    required TextEditingController emailEcontroller,
    this.emailText,
  }) : _emailEcontroller = emailEcontroller;

  bool validateEmail(String email) {
    String pattern =
        r'^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9]+)*@(gmail|yahoo)\.com$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: emailText != null
          ? TextFormField(
              initialValue: emailText,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Email",
                labelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade700,
                  letterSpacing: 0.4,
                  fontSize: 12.h,
                ),
                hintStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  letterSpacing: 0.4,
                  fontSize: 12.h,
                ),
                prefixIcon: Icon(Icons.email, color: Colors.blue, size: 20.sp),
              ),
            )
          : TextFormField(
              controller: _emailEcontroller,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Email",
                labelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade700,
                  letterSpacing: 0.4,
                  fontSize: 12.h,
                ),
                hintStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  letterSpacing: 0.4,
                  fontSize: 12.h,
                ),
                prefixIcon: Icon(Icons.email, color: Colors.blue, size: 20.sp),
              ),
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email address';
                } else if (!validateEmail(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              autofillHints: [AutofillHints.email],
            ),
    );
  }
}
