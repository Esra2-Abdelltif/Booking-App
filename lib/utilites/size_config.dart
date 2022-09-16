import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenW;
  static double? screenH;
  static double? defaultSize;
  static Orientation? orientation;
  static double? blockH;
  static double? blockV;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenW = _mediaQueryData!.size.width;
    screenH = _mediaQueryData!.size.height;
    blockH = screenW! / 100;
    blockV = screenH! / 100;
    defaultSize = orientation == Orientation.landscape ? screenH! * 0.024 : screenW! * 0.024;
  }
}

double getFont(double size) {
  double defaultsSize = SizeConfig.defaultSize! * size;
  return (defaultsSize / 10);
}

// Get the proportionate height as per screen size
double getHeight(double inputHeight) {
  double? screenHeight = SizeConfig.screenH;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight!;
}

// Get the proportionate width as per screen size
double getWidth(double inputWidth) {
  double? screenWidth = SizeConfig.screenW;
  // 375 is the layout width that Figma provides
  return (inputWidth / 375.0) * screenWidth!;
}