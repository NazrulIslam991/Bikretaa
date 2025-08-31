import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProductExpireDateController extends StatelessWidget {
  const ProductExpireDateController({
    super.key,
    required TextEditingController ProductExpireDateController,
  }) : _ProductExpireDateController = ProductExpireDateController;

  final TextEditingController _ProductExpireDateController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      child: TextFormField(
        controller: _ProductExpireDateController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: "Expire Date",
          labelText: "Expire Date",
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
            _ProductExpireDateController.text = formattedDate;
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Expire date is required';
          }
          return null;
        },
      ),
    );
  }
}
