import 'package:booking_app/Booking_App/features/data/models/user_model.dart';
import 'package:flutter/material.dart';

import '../../features/data/datasources/local/cacheHelper.dart';

class AppConstance{

  static void navigateTo({context,router})=>  Navigator.push(context,MaterialPageRoute(builder: (context) => router));
  static void  navigatePop({context})=>Navigator.pop(context);
  static void navigateByName({context,router})=>  Navigator.pushNamed(context,router);






}
UserModel? userModel;
dynamic onBoarding =CacheHelper.getDate(key: 'onBoarding');//
dynamic appToken =CacheHelper.getDate(key:'token');
String token="ANtoxNSy0CVOdpBG8bkJx65GIMzmzLST0YXkP1cLSe4mpPGLK08MjcOncDwv";


Future  navigateAndFinsh ({context,router})=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => router), (Route<dynamic> route) => false);


void LogOut({context,router}){

  CacheHelper.sharedPreferences!.remove('token').then((value) {
    if(value ){
      navigateAndFinsh(context: context,router: router);
    }

  });
}


