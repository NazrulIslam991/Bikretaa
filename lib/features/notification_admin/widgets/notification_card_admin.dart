import 'package:flutter/material.dart';

import '../../../app/responsive.dart';

class NotificationCardAdmin extends StatelessWidget {
  final Map<String, String> notification;

  const NotificationCardAdmin({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color iconColor = theme.colorScheme.secondary;
    Color cardBackground = theme.cardColor;
    Color audienceColor =
        theme.textTheme.bodyMedium?.color ??
        (isDark ? Colors.white70 : Colors.grey[800]!);
    Color infoColor =
        theme.textTheme.bodySmall?.color ??
        (isDark ? Colors.white60 : Colors.grey[600]!);
    Color titleColor =
        theme.textTheme.bodyLarge?.color ??
        (isDark ? Colors.white : Colors.black87);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(r.radiusMedium()),
      ),
      color: cardBackground,
      margin: EdgeInsets.symmetric(
        vertical: r.height(0.007),
        horizontal: r.width(0.01),
      ),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: r.width(0.03),
          vertical: r.height(0.015),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.notifications,
                  color: iconColor,
                  size: r.iconMedium(),
                ),
                SizedBox(width: r.width(0.02)),
                Expanded(
                  child: Text(
                    notification["title"] ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: r.fontMedium(),
                      color: titleColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: r.height(0.008)),

            // Message
            Text(
              notification["message"] ?? "",
              style: TextStyle(
                fontSize: r.fontSmall(),
                color: titleColor.withAlpha((0.9 * 255).round()),
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: r.height(0.01)),

            // Footer Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Audience
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: r.width(0.03),
                    vertical: r.height(0.008),
                  ),
                  decoration: BoxDecoration(
                    color: audienceColor.withAlpha((0.12 * 255).round()),
                    borderRadius: BorderRadius.circular(r.radiusLarge()),
                  ),
                  child: Text(
                    notification["audience"] ?? "",
                    style: TextStyle(
                      fontSize: r.fontSmall(),
                      color: audienceColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Time
                Text(
                  "${notification["recipients"]} recipients · ${notification["time"]}",
                  style: TextStyle(fontSize: r.fontSmall(), color: infoColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
