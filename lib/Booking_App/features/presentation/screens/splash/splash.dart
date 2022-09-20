
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/Core/utilites/assets_manager.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/account/login/login_screen_.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/app_layout.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/onboarding/onBoarding_screen.dart';

import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget RightScreen;

    if(onBoarding !=null)
    {
      if(appToken!=null){
        RightScreen= AppLayout();
      }
      else{
        RightScreen =LoginScreen();}
    }
    else{
      RightScreen = OnBoardinScreen();
    }
    return  AnimatedSplashScreen(
      duration: 400,
      splash: Column(children: [
        Image.asset(ImageAssets.appLogo,width: 150,height: 140),
        SizedBox(height: 15,),
        Text(AppString.appTitle,style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.black54),)
      ]),
      nextScreen:RightScreen,
      splashIconSize: 250,
      splashTransition: SplashTransition.slideTransition,


    );

  }
  }

