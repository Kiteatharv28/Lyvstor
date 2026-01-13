import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double getScreenPadding(BuildContext context) {
    if (isMobile(context)) return 16.0;
    if (isTablet(context)) return 24.0;
    return 32.0;
  }

  static double getGridCrossAxisCount(BuildContext context) {
    if (isMobile(context)) return 2;
    if (isTablet(context)) return 3;
    return 4;
  }

  static double getGridChildAspectRatio(BuildContext context) {
    if (isMobile(context)) return 0.60;
    if (isTablet(context)) return 0.65;
    return 0.70;
  }

  static double getFontSize(BuildContext context, double baseSize) {
    double width = getWidth(context);
    if (width < 400) return baseSize * 0.85;
    if (width < 600) return baseSize;
    if (width < 900) return baseSize * 1.1;
    return baseSize * 1.2;
  }

  static double getResponsiveValue(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  static int getCrossAxisCount(BuildContext context) {
    return getGridCrossAxisCount(context).toInt();
  }

  static EdgeInsets getResponsivePadding(BuildContext context) {
    double padding = getScreenPadding(context);
    return EdgeInsets.all(padding);
  }

  static EdgeInsets getResponsiveHorizontalPadding(BuildContext context) {
    double padding = getScreenPadding(context);
    return EdgeInsets.symmetric(horizontal: padding);
  }

  static EdgeInsets getResponsiveVerticalPadding(BuildContext context) {
    double padding = getScreenPadding(context);
    return EdgeInsets.symmetric(vertical: padding);
  }

  static double getResponsiveHeight(BuildContext context, double percentage) {
    return getHeight(context) * (percentage / 100);
  }

  static double getResponsiveWidth(BuildContext context, double percentage) {
    return getWidth(context) * (percentage / 100);
  }

  static BorderRadius getResponsiveBorderRadius(BuildContext context) {
    if (isMobile(context)) return BorderRadius.circular(12);
    if (isTablet(context)) return BorderRadius.circular(16);
    return BorderRadius.circular(20);
  }

  static double getResponsiveIconSize(BuildContext context) {
    if (isMobile(context)) return 24;
    if (isTablet(context)) return 28;
    return 32;
  }

  static double getResponsiveButtonHeight(BuildContext context) {
    if (isMobile(context)) return 48;
    if (isTablet(context)) return 52;
    return 56;
  }

  static double getResponsiveImageHeight(BuildContext context) {
    if (isMobile(context)) return 200;
    if (isTablet(context)) return 250;
    return 300;
  }

  static double getResponsiveMaxWidth(BuildContext context) {
    if (isMobile(context)) return double.infinity;
    if (isTablet(context)) return 800;
    return 1200;
  }

  static Orientation getOrientation(BuildContext context) =>
      MediaQuery.of(context).orientation;

  static bool isLandscape(BuildContext context) =>
      getOrientation(context) == Orientation.landscape;

  static bool isPortrait(BuildContext context) =>
      getOrientation(context) == Orientation.portrait;
}
