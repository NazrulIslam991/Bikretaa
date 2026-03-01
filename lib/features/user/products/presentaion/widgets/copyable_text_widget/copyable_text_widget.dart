import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyableText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final double iconSize;
  final Color iconColor;
  final bool showSnackBar;

  const CopyableText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.textColor = Colors.black,
    this.iconSize = 18,
    this.iconColor = Colors.blue,
    this.showSnackBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, color: textColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 5),
        InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () {
            Clipboard.setData(ClipboardData(text: text));
            if (showSnackBar) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Copied: $text'),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(Icons.copy, size: iconSize, color: iconColor),
          ),
        ),
      ],
    );
  }
}
