import 'package:booking_app/presentation/widgets/CustomTextButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomRowText extends StatelessWidget {
  final String Text1;
  final String Text2;
  final Color textcolor;
  final VoidCallback onPressed;


  const CustomRowText({Key? key,required this.Text1,required this.Text2,required this.onPressed,required this.textcolor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Text1,style:TextStyle(fontWeight: FontWeight.w600,)),
        CustomTextButton(text: Text2,textcolor: textcolor, onPressed:onPressed,),

      ],
    );
  }
}
