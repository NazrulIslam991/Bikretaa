import 'package:flutter/material.dart';

enum DeviceType { small, medium, large }

class ResponsiveHelper {
  final BuildContext context;
  late final DeviceType deviceType;

  ResponsiveHelper(this.context) {
    double width = MediaQuery.of(context).size.width;

    if (width < 360) {
      deviceType = DeviceType.small;
    } else if (width >= 360 && width < 420) {
      deviceType = DeviceType.medium;
    } else {
      deviceType = DeviceType.large;
    }
  }
}
