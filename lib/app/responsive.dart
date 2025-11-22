import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  final Size size;
  final double textScaleFactor;

  Responsive._(this.context, this.size, this.textScaleFactor);

  static Responsive of(BuildContext context) {
    final media = MediaQuery.of(context);
    return Responsive._(context, media.size, media.textScaleFactor);
  }

  // Width & Height Scale
  double width(double fraction) => size.width * fraction;
  double height(double fraction) => size.height * fraction;

  // Font Scale (adaptive to system text scale)
  double fontextraSmall() => adaptiveFont(0.02);
  double fontSmall() => adaptiveFont(0.03);
  double fontMedium() => adaptiveFont(0.032);
  double fontLarge() => adaptiveFont(0.038);
  double fontXL() => adaptiveFont(0.050);
  double fontXXL() => adaptiveFont(0.063);
  double fontXXXL() => adaptiveFont(0.073);

  double adaptiveFont(double fraction) {
    if (isTablet) return size.width * fraction * 1.2 / textScaleFactor;
    if (isPhone && size.width < 350) {
      return size.width * fraction * 0.9 / textScaleFactor;
    }
    return size.width * fraction / textScaleFactor;
  }

  // Padding
  double paddingextraSmall() => width(0.01);
  double paddingSmall() => width(0.02);
  double paddingMedium() => width(0.03);
  double paddingLarge() => width(0.05);
  double paddingXLarge() => width(0.06);
  double duefeildPadding() => width(0.04);

  // Radius
  double radiusSmall() => width(0.02);
  double radiusMedium() => width(0.03);
  double radiusLarge() => width(0.05);

  // Icon Sizes
  double iconSmall() => width(0.04);
  double iconMedium() => width(0.05);
  double iconLarge() => width(0.07);
  double iconXXLarge() => width(0.08);

  // Spacing Widgets
  SizedBox vSpace(double fraction) => SizedBox(height: height(fraction));
  SizedBox hSpace(double fraction) => SizedBox(width: width(fraction));

  // Device Type Detection
  bool get isTablet => size.shortestSide >= 600;
  bool get isPhone => size.shortestSide < 600;

  // Adaptive Text Style
  TextStyle textStyle({
    double? fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
    double? height,
  }) {
    return TextStyle(
      fontSize: (fontSize ?? fontMedium()),
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  // Responsive Grid Helper
  int get responsiveCrossAxisCount {
    if (size.width > 1200) return 5;
    if (size.width > 900) return 4;
    if (isTablet) return 3;
    return 2;
  }

  ///this section only for calculator
}
