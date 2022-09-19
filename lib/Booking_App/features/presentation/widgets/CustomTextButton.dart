import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class  CustomTextButton  extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textcolor;

  const CustomTextButton({Key? key,required this.text,required this.onPressed, required this.textcolor}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  TextButton(onPressed: onPressed, child: Text(text,style:TextStyle(color: textcolor ) ,));
  }
}
