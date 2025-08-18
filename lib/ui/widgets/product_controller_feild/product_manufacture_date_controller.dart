import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProductManufactureDateController extends StatelessWidget {
  const ProductManufactureDateController({
    super.key,
    required TextEditingController productManufactureDateController,
  }) : _productManufactureDateController = productManufactureDateController;

  final TextEditingController _productManufactureDateController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _productManufactureDateController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: "Manufacture Date",
          labelText: "Manufacture Date",
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
          );

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            _productManufactureDateController.text = formattedDate;
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Manufacture date  is required';
          }
          return null;
        },
      ),
    );
  }
}
