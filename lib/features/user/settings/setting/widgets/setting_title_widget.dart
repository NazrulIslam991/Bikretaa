import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';

class SettingsTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool danger;

  const SettingsTileWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: r.width(0.035),
        vertical: r.height(0.001),
      ),
      leading: Container(
        width: r.width(0.07),
        height: r.height(0.04),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(r.radiusSmall()),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.blue, size: r.fontSmall()),
      ),
      title: Text(
        title,
        style: r.textStyle(
          fontSize: r.fontLarge(),
          fontWeight: FontWeight.w500,
          color: danger ? Colors.red : theme.colorScheme.primary,
        ),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle!,
              style: r.textStyle(
                fontSize: r.fontSmall(),
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w300,
              ),
            ),
      trailing:
          trailing ?? Icon(Icons.chevron_right_rounded, size: r.fontSmall()),
      onTap: onTap,
    );
  }
}
