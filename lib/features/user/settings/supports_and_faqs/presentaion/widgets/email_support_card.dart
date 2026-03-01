import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailSupportCard extends StatelessWidget {
  final ThemeData theme;
  final VoidCallback onPressed;

  const EmailSupportCard({
    super.key,
    required this.theme,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final blue = const Color(0xFF007BFF);

    return Container(
      padding: EdgeInsets.all(r.paddingMedium()),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(r.radiusMedium()),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: r.width(0.008),
            offset: Offset(0, r.height(0.002)),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'email_support_desc'.tr,
            style: r.textStyle(
              fontSize: r.fontMedium(),
              color: theme.colorScheme.onSurface.withOpacity(0.85),
            ),
          ),
          r.vSpace(0.015),
          ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(
              Icons.mail_outline,
              color: Colors.white,
              size: r.iconMedium(),
            ),
            label: Text(
              'contact_support'.tr,
              style: r.textStyle(fontSize: r.fontMedium(), color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: blue,
              minimumSize: Size(double.infinity, r.height(0.04)),
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
