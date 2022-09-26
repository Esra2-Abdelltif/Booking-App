 import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ThemeAppStates
{
  const ThemeAppStates();
}
 class InitialThemeAppState extends ThemeAppStates{}

class AppChangeModeState extends ThemeAppStates {}
 class AppChangeLangtate extends ThemeAppStates {}
 class ChangeState extends ThemeAppStates {}






