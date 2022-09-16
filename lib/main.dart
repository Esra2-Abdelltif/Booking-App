import 'package:booking_app/layout/theme/themes/light_theme.dart';
import 'package:booking_app/presentation/screens/onboarding/onBoarding_screen.dart';
import 'package:booking_app/utilites/app_strings.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppString.appTitle,
      debugShowCheckedModeBanner: false,
      theme:lightthemes,
      home: OnBoardinScreen(),
    );
  }
}

