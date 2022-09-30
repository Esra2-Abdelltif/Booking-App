import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/account/login/login_screen_.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/hotel_details/hotel_details_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/search_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/custom_appBar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../config/themes/cubit/cubit.dart';
import '../../../../../config/themes/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title:  Text(AppString.settings, style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,

          )),),
          body: SingleChildScrollView(
            child:  Padding(
              padding: const EdgeInsets.only(
                left: 24,

                right: 24,
              ),
              child: Column(
                children:  [
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () {

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20,),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Theme Mode",
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 16,)),
                          SwitchTheme()

                        ],
                      ),
                    ),
                  ),
                  Divider(
                      height: 1,
                      color: AppColors.grey.withOpacity(.4),
                      thickness: 1),

                  InkWell(
                    onTap: () {

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20,top: 20),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Terms of Services",
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 16,)),
                          Icon(Icons.arrow_forward_ios_rounded,color: AppColors.grey.withOpacity(.7),)

                        ],
                      ),
                    ),
                  ),
                  Divider(
                      height: 1,
                      color: AppColors.grey.withOpacity(.4),
                      thickness: 1),
                  InkWell(
                    onTap: () {

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20,top: 20),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Privacy Policy",
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 16,)),
                          Icon(Icons.arrow_forward_ios_rounded,color: AppColors.grey.withOpacity(.7),)

                        ],
                      ),
                    ),
                  ),
                  Divider(
                      height: 1,
                      color: AppColors.grey.withOpacity(.4),
                      thickness: 1),
                  InkWell(
                    onTap: () {

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20,top: 20),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Give Us Feedbacks",
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 16,)),
                          Icon(Icons.arrow_forward_ios_rounded,color: AppColors.grey.withOpacity(.7),)

                        ],
                      ),
                    ),
                  ),
                  Divider(
                      height: 1,
                      color: AppColors.grey.withOpacity(.4),
                      thickness: 1),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Log out ? ',style: TextStyle(color: Colors.white, fontSize: 18)),
                              content: const Text('Do You sure to log out ?',  style: TextStyle(color: Colors.white, fontSize: 18)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel',  style: TextStyle(color: Colors.white, fontSize: 18)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    LogOut(context: context,router: LoginScreen());

                                  },
                                  child: const Text('Log out',  style: TextStyle(color:Colors.white, fontSize: 18)),
                                ),
                              ],
                              elevation: 24,
                              backgroundColor: AppColors.defultColor,
                              // shape: CircleBorder(),
                            );
                          }
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20,top: 20),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text("LogOut",
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 16,)),
                          Icon(Icons.arrow_forward_ios_rounded,color: AppColors.grey.withOpacity(.7),)

                        ],
                      ),
                    ),
                  ),
                  Divider(
                      height: 1,
                      color: AppColors.grey.withOpacity(.4),
                      thickness: 1),



                ],

              ),
            ),
          ),

        );
      },
    );
  }
}

class SwitchTheme extends StatelessWidget {
  const SwitchTheme({ Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
         return BlocConsumer<ThemeAppCubit, ThemeAppStates>(
           listener: (BuildContext context, ThemeAppStates state) {
             if(state is AppChangeModeState ){
             };
           },
           builder: (BuildContext context,  ThemeAppStates state) {
             return CupertinoSwitch(
               value: ThemeAppCubit.get(context).IsDark,
               activeColor: Theme.of(context).primaryColor,
               onChanged: (value) {
                 ThemeAppCubit.get(context).ChangeAppMode();

               },
             );
           },
         );
  }
}