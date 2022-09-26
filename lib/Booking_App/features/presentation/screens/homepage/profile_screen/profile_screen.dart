import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/Core/utilites/assets_manager.dart';
import 'package:booking_app/Booking_App/config/themes/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/profile_screen/update_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/custom_appBar_view.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (context, state) {
        var cubit = AppBloc.get(context).profileModel;
        return Scaffold(
            body: ConditionalBuilder(
              condition: AppBloc.get(context).profileModel != null,
              builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 60.0,horizontal: 24),
                          child: Column(
                            children: [
                              Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5,),
                                    Text(
                          cubit!.data!.name!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        color: ThemeAppCubit.get(context).IsDark
                                            ?AppColors.white
                                            : AppColors.darkcontiner,
                                      ),
                                    ),
                                    SizedBox(height: 7,),
                                    Text(
                                      cubit.data!.email!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        color: ThemeAppCubit.get(context).IsDark
                                            ? Colors.white54
                                            : AppColors.grey,
                                      ),
                                    )
                                  ],
                                ),
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundColor: AppColors.white,
                                    backgroundImage:
                                    AssetImage(ImageAssets.userProfile),
                                  ),
                              ],),
                              SizedBox(
                                height: 20,
                              ),
                              //Edit Profile
                              InkWell(
                                onTap: () {
                                  AppConstance.navigateTo(
                                      context: context, router: UpDateScreen());

                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20,top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(AppString.editProfile,
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 16,)),
                                      Icon( Icons.edit_rounded,color: AppColors.grey.withOpacity(.7),)

                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                  height: 1,
                                  color: AppColors.grey.withOpacity(.4),
                                  thickness: 1),
                              //invite Friends
                              InkWell(
                                onTap: () {

                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20,top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("invite Friends",
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 16,)),
                                      Icon( Icons.people,color: AppColors.grey.withOpacity(.7),)

                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                  height: 1,
                                  color: AppColors.grey.withOpacity(.4),
                                  thickness: 1),
                              //Crdit & Coupons
                              InkWell(
                                onTap: () {

                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20,top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Crdit & Coupons",
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 16,)),
                                      Icon( FontAwesomeIcons.gift,color: AppColors.grey.withOpacity(.7),)

                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                  height: 1,
                                  color: AppColors.grey.withOpacity(.4),
                                  thickness: 1),
                              //Help Center
                              InkWell(
                                onTap: () {

                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20,top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Help Center",
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 16,)),
                                      Icon( Icons.info,color: AppColors.grey.withOpacity(.7),)

                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                  height: 1,
                                  color: AppColors.grey.withOpacity(.4),
                                  thickness: 1),
                              //Payment
                              InkWell(
                                onTap: () {

                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20,top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Payment",
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 16,)),
                                      Icon(FontAwesomeIcons.wallet,color: AppColors.grey.withOpacity(.7),)

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
                      )),
                ],
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ));
      },
    );
  }
}