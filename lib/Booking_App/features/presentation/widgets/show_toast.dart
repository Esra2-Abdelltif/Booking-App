import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Future<bool?> showToastMsg(
    {required String massage,
      required ToastState state,
      int? timeInSecForIosWeb,
      ToastGravity gravity = ToastGravity.BOTTOM,
      required Toast toastLength}) =>
    Fluttertoast.showToast(
        msg: massage,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);


Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.blue;
      break;
  }
  return color;
}
enum ToastState { SUCCESS, ERROR, WARNING }
