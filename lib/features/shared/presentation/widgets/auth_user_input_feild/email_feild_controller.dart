import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return Container(
      //height: r.height(0.06),
      child: emailText != null
          ? TextFormField(
              initialValue: emailText,
              style: TextStyle(
                fontSize: r.fontMedium(),
                color: theme.colorScheme.onBackground,
              ),
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Email'.tr,
                hintText: 'Email'.tr,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: theme.colorScheme.primary,
                  letterSpacing: 0.4,
                  fontSize: r.fontMedium(),
                ),
                hintStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: theme.colorScheme.primary,
                  letterSpacing: 0.4,
                  fontSize: r.fontMedium(),
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.blue,
                  size: r.iconMedium(),
                ),
              ),
            )
          : TextFormField(
              controller: _emailEcontroller,
              style: TextStyle(
                fontSize: r.fontMedium(),
                color: theme.colorScheme.onBackground,
              ),
              decoration: InputDecoration(
                labelText: 'Email'.tr,
                hintText: 'Email'.tr,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: theme.colorScheme.primary,
                  letterSpacing: 0.4,
                  fontSize: r.fontMedium(),
                ),
                hintStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: theme.colorScheme.primary,
                  letterSpacing: 0.4,
                  fontSize: r.fontMedium(),
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.blue,
                  size: r.iconMedium(),
                ),
              ),
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please_enter_an_email_address'.tr;
                } else if (!validateEmail(value)) {
                  return 'Please_enter_a_valid_email_address'.tr;
                }
                return null;
              },
              autofillHints: [AutofillHints.email],
            ),
    );
  }
}
