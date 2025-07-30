import 'package:flutter/material.dart';

class AdaptiveSize {
  static double? _screenWidth;
  static double? _screenHeight;
  static double? _devicePixelRatio;
  static double? _baseHeight;
  static double? _baseWidth;

  static double get screenWidth => _screenWidth ?? 428.0;
  static double get screenHeight => _screenHeight ?? 926.0;
  static double get devicePixelRatio => _devicePixelRatio ?? 1.0;
  static double get baseHeight => _baseHeight ?? 926.0;
  static double get baseWidth => _baseWidth ?? 428.0;

  static void init(
    BuildContext context, {
    double baseHeightValue = 926.0,
    double baseWidthValue = 428.0,
  }) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _devicePixelRatio = mediaQuery.devicePixelRatio;
    _baseHeight = baseHeightValue;
    _baseWidth = baseWidthValue;
  }

  static double h(double heightPx) {
    double scaleFactor = screenHeight / baseHeight;
    return heightPx * scaleFactor.clamp(0.8, 1.2);
  }

  static double w(double widthPx) {
    double scaleFactor = screenWidth / baseWidth;
    return widthPx * scaleFactor.clamp(0.8, 1.2);
  }

  static double sp(double fontSizePx) {
    double scaleFactor = screenHeight / baseHeight;
    return fontSizePx * scaleFactor.clamp(0.9, 1.1);
  }
}
