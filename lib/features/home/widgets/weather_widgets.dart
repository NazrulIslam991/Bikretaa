import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../app/controller/weather_controller.dart';

class WeatherChip extends StatelessWidget {
  WeatherChip({super.key});
  final WeatherController controller = Get.put(WeatherController());

  // Open device location settings
  void _openLocationSettings() async {
    if (!await Geolocator.openLocationSettings()) {
      debugPrint("could_not_open_location".tr);
    }
  }

  // Handle tap → check permission & service, then load weather
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

    return Obx(() {
      final temperature = controller.temperature.value;
      final icon = controller.weatherIcon.value;
      final isLoading = controller.isLoading.value;

      return GestureDetector(
        onTap: _handleTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary.withAlpha((0.12 * 255).round()),
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16.r),
              SizedBox(width: 6.w),
              isLoading
                  ? SizedBox(
                      width: 12.w,
                      height: 12.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.w,
                        color: theme.colorScheme.primary,
                      ),
                    )
                  : Text(
                      temperature.isNotEmpty ? temperature : '--°C',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
            ],
          ),
        ),
      );
    });
  }
}
