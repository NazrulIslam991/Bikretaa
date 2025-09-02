import 'package:bikretaa/app/theme_controller.dart';
import 'package:bikretaa/assets_path/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyBackground extends StatelessWidget {
  final Widget child;

  const BodyBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() {
      if (themeController.isDarkMode.value) {
        return Container(color: theme.colorScheme.onSecondary, child: child);
      } else {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetPaths.background),
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        );
      }
    });
  }
}
