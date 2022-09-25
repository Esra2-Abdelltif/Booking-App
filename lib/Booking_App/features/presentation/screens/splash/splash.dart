
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/Core/utilites/assets_manager.dart';
import 'package:booking_app/Booking_App/config/themes/cubit/cubit.dart';
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
      duration: 600,
      backgroundColor:  ThemeAppCubit.get(context).IsDark ? AppColors.scafolldDark: AppColors.white,
      splash: Column(children: [
        Image.asset(ImageAssets.appLogo_2,width: 150,height: 140),
        SizedBox(height: 15,),
        Text(AppString.appTitle,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:AppColors.black.withOpacity(.7),fontFamily: 'Poppins'),)
      ]),
      nextScreen:RightScreen,
      splashIconSize: 250,
      splashTransition: SplashTransition.scaleTransition,


    );

  }
  }

