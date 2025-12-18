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

    final textColor = theme.brightness == Brightness.dark
        ? Colors.white
        : Colors.black87;
    final hintColor = theme.brightness == Brightness.dark
        ? Colors.white54
        : Colors.black54;
    final borderColor = theme.colorScheme.primary;
    final backgroundColor = theme.colorScheme.onPrimary;

    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
      hint: Text(
        'Select Shop Type',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: theme.colorScheme.primary,
          fontSize: r.fontMedium(),
        ),
      ),
      value: selectedValue,
      items: shopTypes
          .map(
            (type) => DropdownMenuItem<String>(
              value: type,
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: EdgeInsets.only(right: r.width(0.02)),
                    decoration: BoxDecoration(
                      color: textColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      type,
                      style: TextStyle(
                        fontSize: r.fontMedium(),
                        color: textColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select shop type'.tr;
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
      onSaved: widget.onSaved,
      buttonStyleData: ButtonStyleData(
        height: r.height(0.065),
        padding: EdgeInsets.symmetric(horizontal: r.width(0.03)),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(r.radiusSmall()),
        //   border: Border.all(color: borderColor),
        //   color: backgroundColor,
        // ),
        elevation: 2,
      ),
      iconStyleData: IconStyleData(
        icon: Icon(Icons.arrow_forward_ios_outlined, size: r.iconMedium()),
        iconEnabledColor: hintColor,
        iconDisabledColor: Colors.grey,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: r.height(0.25),
        width: r.width(0.92),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(r.radiusMedium()),
          color: backgroundColor,
          border: Border.all(color: borderColor),
        ),
        offset: const Offset(0, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all(6),
          thumbVisibility: MaterialStateProperty.all(true),
        ),
      ),
      menuItemStyleData: MenuItemStyleData(
        height: r.height(0.05),
        padding: EdgeInsets.symmetric(horizontal: r.width(0.03)),
      ),
    );
  }
}
