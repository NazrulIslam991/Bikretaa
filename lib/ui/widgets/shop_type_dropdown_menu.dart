import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

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
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      hint: const Text('Select Shop Type', style: TextStyle(fontSize: 15)),
      items: shopTypes
          .map(
            (type) => DropdownMenuItem<String>(
              value: type,
              child: Text(type, style: const TextStyle(fontSize: 15)),
            ),
          )
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select shop type.';
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
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(Icons.arrow_drop_down, color: Colors.black45),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
