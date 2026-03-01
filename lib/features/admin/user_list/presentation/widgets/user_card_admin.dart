import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class UserCardAdmin extends StatelessWidget {
  final Map<String, dynamic> user;
  const UserCardAdmin({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context); // Use your custom Responsive
    final isDark = theme.brightness == Brightness.dark;

    // Colors adapted from the theme
    Color statusColor = user['status'] == "Active"
        ? theme.colorScheme.secondary
        : theme.colorScheme.error;

    Color cardBackground = theme.cardColor;
    Color shadowColor = theme.shadowColor;
    Color avatarBg = theme.colorScheme.primary;

    Color titleColor =
        theme.textTheme.bodyLarge?.color ??
        (isDark ? Colors.white : Colors.black87);
    Color subtitleColor =
        theme.textTheme.bodyMedium?.color ??
        (isDark ? Colors.white70 : Colors.grey[700]!);
    Color metaColor =
        theme.textTheme.bodySmall?.color ??
        (isDark ? Colors.white60 : Colors.grey[600]!);

    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: r.height(0.005)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(r.radiusMedium()),
      ),
      shadowColor: shadowColor,
      color: cardBackground,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: r.height(0.01),
          horizontal: r.width(0.02),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(r.radiusMedium()),
          color: cardBackground,
        ),
        child: Row(
          children: [
            // Left colored status bar
            Container(
              width: r.width(0.015),
              height: r.height(0.08),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(r.radiusMedium()),
                  bottomLeft: Radius.circular(r.radiusMedium()),
                ),
              ),
            ),
            r.hSpace(0.02),
            // Avatar
            CircleAvatar(
              radius: r.width(0.06),
              backgroundColor: avatarBg,
              child: Text(
                (user['name'] as String).isNotEmpty ? user['name'][0] : '?',
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontSize: r.fontMedium(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            r.hSpace(0.02),
            // User details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: r.textStyle(
                      fontSize: r.fontMedium(),
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
                  ),
                  r.vSpace(0.002),
                  Text(
                    user['shop'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: r.textStyle(
                      fontSize: r.fontSmall(),
                      color: subtitleColor,
                    ),
                  ),
                  r.vSpace(0.002),
                  Text(
                    user['email'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: r.textStyle(
                      fontSize: r.fontSmall() * 0.9,
                      color: metaColor,
                    ),
                  ),
                  r.vSpace(0.002),
                  Text(
                    "Last login: ${user['lastLogin']}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: r.textStyle(
                      fontSize: r.fontSmall() * 0.85,
                      color: metaColor,
                      //fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            r.hSpace(0.02),
            // Status chip
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: r.width(0.025),
                vertical: r.height(0.005),
              ),
              decoration: BoxDecoration(
                color: statusColor.withAlpha((0.15 * 255).round()),
                borderRadius: BorderRadius.circular(r.radiusLarge()),
              ),
              child: Text(
                user['status'],
                style: r.textStyle(
                  fontSize: r.fontSmall(),
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ),
            r.hSpace(0.01),
            Icon(Icons.more_vert, size: r.iconSmall(), color: metaColor),
            r.hSpace(0.01),
          ],
        ),
      ),
    );
  }
}
