import 'package:bikretaa/app/responsive.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class Custom_Dropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final Function(String?) onChanged;

  const Custom_Dropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);

    final textColor = theme.brightness == Brightness.dark
        ? Colors.white
        : Colors.black87;
    final hintColor = theme.brightness == Brightness.dark
        ? Colors.white54
        : Colors.black54;
    final borderColor = theme.colorScheme.secondary;
    final backgroundColor = theme.colorScheme.onPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: r.fontSmall(),
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        SizedBox(height: r.height(0.008)),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            value: value,
            items: items
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
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
                            item,
                            style: TextStyle(
                              fontSize: r.fontSmall(),
                              fontWeight: FontWeight.bold,
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
            onChanged: onChanged,
            hint: Text(
              'Select $label',
              style: TextStyle(
                fontSize: r.fontSmall(),
                fontWeight: FontWeight.bold,
                color: hintColor,
              ),
            ),
            buttonStyleData: ButtonStyleData(
              height: r.height(0.065),
              padding: EdgeInsets.symmetric(horizontal: r.width(0.03)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(r.radiusMedium()),
                border: Border.all(color: borderColor),
                color: backgroundColor,
              ),
              elevation: 2,
            ),
            iconStyleData: IconStyleData(
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              iconSize: r.fontMedium(),
              iconEnabledColor: hintColor,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: r.height(0.25),
              width: r.width(0.375),
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
          ),
        ),
      ],
    );
  }
}
