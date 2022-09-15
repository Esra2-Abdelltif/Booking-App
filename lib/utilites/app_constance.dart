import 'package:flutter/material.dart';

class AppConstance{
  static void navigateTo({context,router})=>  Navigator.push(context,MaterialPageRoute(builder: (context) => router));
  static void  navigatePop({context})=>Navigator.pop(context);
  static void navigateByName({context,router})=>  Navigator.pushNamed(context,router);
  Future navigateAndFinsh ({context,router})=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => router), (Route<dynamic> route) => false);




}


