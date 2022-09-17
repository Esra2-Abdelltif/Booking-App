import 'package:booking_app/presentation/widgets/customButton.dart';
import 'package:booking_app/utilites/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:booking_app/presentation/screens/onboarding/onBoarding_screen.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: AppColors.white,

    body:SingleChildScrollView (
      child : Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0,bottom: 20),
            child: Center(
              child: Container(
                  width: 200,
                  height: 150,
                  child: Image.asset('assests/images/booking_logo.png')),
            ),
          ),


          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'booking@gmail.com'),
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: TextField(

              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'password'),
            ),
          ),


          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CustomButton(
              text: 'Forgot Password',
              width: double.infinity,
              color: AppColors.white,
              Fontcolor: AppColors.defultColor,
              onTap: (){
              /*  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OnBoardinScreen()),
                );*/
              },
              borderColor: AppColors.white,
            ),
          ),


          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CustomButton(
              height: 50,
              fontsize: 25,
              text: 'Sign In',
              width: 250,
              color: AppColors.defultColor,
              Fontcolor: AppColors.white,
              onTap: (){
              /*  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OnBoardinScreen()),
                );*/
              },
              borderColor: AppColors.defultColor,
            ),
          ),






        ],
      )


    ));
  }
}