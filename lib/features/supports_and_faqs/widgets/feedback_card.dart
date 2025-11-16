import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackCard extends StatelessWidget {
  final ThemeData theme;
  final TextEditingController controller;
  final int charCount;
  final Function(String) onChanged;
  final VoidCallback onSend;

  const FeedbackCard({
    super.key,
    required this.theme,
    required this.controller,
    required this.charCount,
    required this.onChanged,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final green = const Color(0xFF28A745);

    return Container(
      padding: EdgeInsets.all(r.paddingMedium()),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(r.radiusMedium()),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: Offset(0, r.height(0.002)),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'feedback_desc'.tr,
            style: TextStyle(
              fontSize: r.fontSmall(),
              color: theme.colorScheme.onSurface.withOpacity(0.85),
            ),
          ),
          SizedBox(height: r.height(0.015)),
          TextField(
            controller: controller,
            maxLines: 5,
            maxLength: 500,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: 'feedback_hint'.tr,
              hintStyle: TextStyle(
                fontWeight: FontWeight.normal,
                color: theme.colorScheme.primary,
                letterSpacing: 0.4,
                fontSize: r.fontSmall(),
              ),
              counterText: "",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(r.radiusSmall()),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: r.paddingMedium(),
                vertical: r.height(0.015),
              ),
            ),
          ),
          SizedBox(height: r.height(0.01)),
          Row(
            children: [
              Text(
                '$charCount/500',
                style: TextStyle(
                  fontSize: r.fontSmall() * 0.8,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: green,
                    size: r.fontSmall(),
                  ),
                  SizedBox(width: r.width(0.015)),
                  Text(
                    'instant_admin_notif'.tr,
                    style: TextStyle(
                      fontSize: r.fontSmall() * 0.85,
                      color: green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: r.height(0.015)),
          ElevatedButton.icon(
            onPressed: onSend,
            icon: Icon(Icons.send, size: r.fontMedium()),
            label: Text(
              'send_message'.tr,
              style: TextStyle(fontSize: r.fontMedium()),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: green,
              minimumSize: Size(double.infinity, r.height(0.035)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(r.radiusSmall()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
