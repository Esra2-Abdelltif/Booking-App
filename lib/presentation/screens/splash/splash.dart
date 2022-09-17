
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:booking_app/presentation/screens/onboarding/onBoarding_screen.dart';
import 'package:booking_app/utilites/app_strings.dart';
import 'package:booking_app/utilites/assets_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 1500,
      splash: Column(
          children: [
        Expanded(child: Image.asset(ImageAssets.appLogo, width: 150, height: 140)),
        SizedBox(
          height: 35,
        ),
        Text(
          AppString.appTitle,
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black54),
        )
      ]),
      nextScreen: OnBoardinScreen(),
      splashIconSize: 250,
      splashTransition: SplashTransition.slideTransition,
    );
  }
}
