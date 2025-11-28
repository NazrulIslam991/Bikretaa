import 'package:bikretaa/app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../app/controller/weather_controller/weather_controller.dart';

class WeatherChip extends StatelessWidget {
  WeatherChip({super.key});
  final WeatherController controller = Get.put(WeatherController());

  // Open device location settings
  void _openLocationSettings() async {
    if (!await Geolocator.openLocationSettings()) {
      debugPrint("could_not_open_location".tr);
    }
  }

  Future<void> _handleTap() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled) {
      _openLocationSettings();
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "permission_denied".tr,
        "permission_message".tr,
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    await controller.loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = Responsive.of(context);

    return Obx(() {
      final temperature = controller.temperature.value;
      final icon = controller.weatherIcon.value;
      final isLoading = controller.isLoading.value;

      return GestureDetector(
        onTap: _handleTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: r.width(0.02),
            vertical: r.height(0.008),
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary.withAlpha((0.12 * 255).round()),
            borderRadius: BorderRadius.circular(r.radiusMedium()),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: r.iconSmall()),
              r.hSpace(0.015),
              isLoading
                  ? SizedBox(
                      width: r.width(0.03),
                      height: r.width(0.03),
                      child: CircularProgressIndicator(
                        strokeWidth: r.width(0.004),
                        color: theme.colorScheme.primary,
                      ),
                    )
                  : Text(
                      temperature.isNotEmpty ? temperature : '--°C',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: r.fontSmall(),
                      ),
                    ),
            ],
          ),
        ),
      );
    });
  }
}
