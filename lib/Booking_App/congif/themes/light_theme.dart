import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightthemes = ThemeData(

  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 15,
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color:Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
//fontStyle: FontStyle.italic
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:Brightness.dark,
// statusBarBrightness: Brightness.dark,

    ),
  ),
  drawerTheme: DrawerThemeData(backgroundColor: Colors.white, ),
  textTheme: TextTheme(
    bodyText1: TextStyle(fontSize: 18, fontWeight: FontWeight.w700,color: Colors.black),
    bodyText2:  TextStyle(fontSize: 16, color: Colors.black),
    headline1:TextStyle(fontSize: 30, color: Colors.black54, fontWeight: FontWeight.w600,),
    headline2: TextStyle(fontWeight: FontWeight.w300,color: Color(0xFF8D8E98)),

  ),


);