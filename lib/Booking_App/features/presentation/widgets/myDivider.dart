import 'package:flutter/material.dart';

class  MyDivider extends StatelessWidget {
  final double height;
  final Color bgColor;
  const MyDivider({Key? key,this.height=1.5, this.bgColor=const Color(0xFF8D8E98)}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Divider(
      color: bgColor,
      height:height ,
    );
  }
}
