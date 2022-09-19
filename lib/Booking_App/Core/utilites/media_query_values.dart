import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get toPadding => MediaQuery.of(this).viewPadding.top;
  double get bottom => MediaQuery.of(this).viewInsets.bottom;
  double get height10 => MediaQuery.of(this).size.height/84.4;
  double get height15 => MediaQuery.of(this).size.height/56.27;
  double get height20 => MediaQuery.of(this).size.height/42.2;
  double get height30 => MediaQuery.of(this).size.height/28.13;
  double get width10 => MediaQuery.of(this).size.width/84.4;
  double get width15 => MediaQuery.of(this).size.width/56.27;
  double get width20 => MediaQuery.of(this).size.width/42.2;
  double get width30 => MediaQuery.of(this).size.width/28.13;
  double get splashImage => MediaQuery.of(this).size.height/3.38;

}