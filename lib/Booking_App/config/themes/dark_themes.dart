import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
ThemeData darkthemes = ThemeData(

  primaryColor:  AppColors.defultColor,
  textTheme: TextTheme(
    bodyText1: TextStyle(fontSize: 18, fontWeight: FontWeight.w700,color: Colors.white,),
    bodyText2:  TextStyle(fontSize: 16, color: Colors.white),
    headline1:TextStyle(fontSize: 30, color: Colors.black54, fontWeight: FontWeight.w600,),
    headline2: TextStyle(fontWeight: FontWeight.w300,color: Color(0xFF8D8E98)),
  ),
  fontFamily: 'janna',

  scaffoldBackgroundColor: AppColors.scafolldDark,
  appBarTheme: AppBarTheme(
    titleSpacing: 15,
    iconTheme: IconThemeData(color: AppColors.white),
    backwardsCompatibility: false,
    backgroundColor: AppColors.scafolldDark,
    elevation: 0,
    titleTextStyle: TextStyle(
      color:AppColors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      //fontStyle: FontStyle.italic
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:Brightness.light,


    ),
  ),



  iconTheme: IconThemeData(color: AppColors.black),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor:  AppColors.defultColor,
    unselectedItemColor: Color(0xFF8D8E98),
    backgroundColor: AppColors.scafolldDark,
    elevation: 20,
  ),

);