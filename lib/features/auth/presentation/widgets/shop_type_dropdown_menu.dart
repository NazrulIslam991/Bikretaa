import 'package:bikretaa/app/responsive.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopTypeDropdownWidget extends StatefulWidget {
  final void Function(String?)? onSaved;
  final String? initialValue;

  const ShopTypeDropdownWidget({super.key, this.onSaved, this.initialValue});

  @override
  State<ShopTypeDropdownWidget> createState() => _ShopTypeDropdownWidgetState();
}

class _ShopTypeDropdownWidgetState extends State<ShopTypeDropdownWidget> {
  final List<String> shopTypes = [
    'Grocery',
    'Clothing',
    'Pharmacy',
    'Electronics',
    'Bakery',
    'Hardware',
    'Mobile Store',
  ];

  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: r.height(0.015)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(r.radiusMedium()),
        ),
      ),
      hint: Text(
        'Select_shop_type'.tr,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: theme.colorScheme.primary,
          letterSpacing: 0.4,
          fontSize: r.fontMedium(),
        ),
      ),
      items: shopTypes
          .map(
            (type) => DropdownMenuItem<String>(
              value: type,
              child: Text(type, style: TextStyle(fontSize: r.fontMedium())),
            ),
          )
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please_select_shop_type'.tr;
        }
        return null;
      },
      value: selectedValue,
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
      onSaved: widget.onSaved,
      buttonStyleData: ButtonStyleData(
        padding: EdgeInsets.only(right: r.width(0.02)),
      ),
      iconStyleData: IconStyleData(
        icon: Icon(Icons.arrow_drop_down, color: theme.colorScheme.primary),
        iconSize: r.iconMedium(),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(r.radiusMedium()),
        ),
      ),
      menuItemStyleData: MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: r.width(0.03)),
      ),
    );
  }
}
