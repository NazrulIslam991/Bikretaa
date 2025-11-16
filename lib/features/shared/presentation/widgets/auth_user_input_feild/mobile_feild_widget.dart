import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileFeildWidget extends StatelessWidget {
  const MobileFeildWidget({
    super.key,
    required this.mobileEcontroller,
    this.isEditable = true,
  });

  final TextEditingController mobileEcontroller;
  final bool isEditable;

  bool validatePhone(String phone) {
    String pattern = r'^[3-9]\d{8}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(phone);
  }

  String getFullPhoneNumber() {
    return '+8801${mobileEcontroller.text}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(r.radiusSmall()),
      borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
    );

    return SizedBox(
      height: r.height(0.06),
      child: TextFormField(
        controller: mobileEcontroller,
        keyboardType: TextInputType.number,
        maxLength: 9,
        readOnly: !isEditable,
        style: TextStyle(
          fontSize: r.fontMedium(),
          color: theme.colorScheme.onBackground,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: theme.colorScheme.primary,
            letterSpacing: 0.4,
            fontSize: r.fontMedium(),
          ),
          labelText: 'Phone_Number'.tr,
          prefixText: '+8801 ',
          prefixStyle: TextStyle(
            color: theme.colorScheme.primary,
            fontSize: r.fontMedium(),
            fontWeight: FontWeight.normal,
          ),
          prefixIcon: Icon(
            Icons.phone,
            color: Colors.blue,
            size: r.iconMedium(),
          ),
          counterText: '',
          enabledBorder: baseBorder,
          focusedBorder: isEditable
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(r.radiusSmall()),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                )
              : baseBorder,
          focusedErrorBorder: baseBorder,
        ),
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (!isEditable) return null;
          if (value == null || value.isEmpty) {
            return 'Please_enter_phone_number'.tr;
          } else if (!validatePhone(value)) {
            return 'Please_enter_a_valid_phone_number'.tr;
          }
          return null;
        },
      ),
    );
  }
}
