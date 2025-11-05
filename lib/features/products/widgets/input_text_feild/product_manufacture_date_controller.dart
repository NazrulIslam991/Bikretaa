import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductManufactureDateController extends StatelessWidget {
  const ProductManufactureDateController({
    super.key,
    required TextEditingController productManufactureDateController,
  }) : _productManufactureDateController = productManufactureDateController;

  final TextEditingController _productManufactureDateController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _productManufactureDateController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: "enter_manufacture_date".tr,
          labelText: "manufacture_date".tr,
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: theme.colorScheme.primary,
            letterSpacing: 0.4,
            fontSize: 12.h,
          ),
          hintStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.grey,
            letterSpacing: 0.4,
            fontSize: 12.h,
          ),
          suffixIcon: Icon(Icons.calendar_today),
        ),

        textInputAction: TextInputAction.next,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),

            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  dialogBackgroundColor: Colors.white,
                  colorScheme: ColorScheme.light(
                    primary: Colors.blueAccent,
                    onPrimary: Colors.white,
                    onSurface: Colors.black87,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                  ),
                ),
                child: child!,
              );
            },
          );

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            _productManufactureDateController.text = formattedDate;
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'manufacture_date_required'.tr;
          }
          return null;
        },
      ),
    );
  }
}
