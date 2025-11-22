import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Responsive r;
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ActionButton({
    Key? key,
    required this.r,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Dynamic colors
    final bgColor = isDark ? Colors.grey.shade800 : Color(0xffE4F8EB);
    final iconColor = isDark
        ? Colors.lightGreenAccent.shade400
        : Color(0xff28B576);
    final textColor = isDark ? Colors.white : Colors.black87;

    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: r.width(0.10),
            width: r.width(0.10),
            decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
            child: Icon(icon, size: r.iconSmall(), color: iconColor),
          ),
        ),
        SizedBox(height: r.height(0.008)),
        Text(
          title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: r.fontextraSmall(),
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
