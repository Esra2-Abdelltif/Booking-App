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
              CommonAppbarView(
                //iconData: Icons.arrow_back,
                onBackClick: () {
                  // AppBloc.get(context).userProfile();
                  AppConstance.navigatePop(context: context);
                },
                titleText: AppString.editProfile,
                onTap: () {
                  AppBloc.get(context).userProfile();
                  AppConstance.navigateTo(
                      context: context, router: UpDateScreen());
                },
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor: AppColors.defultColor,
                              child: CircleAvatar(
                                radius: 61,
                                backgroundColor: AppColors.white,
                                backgroundImage:
                                    AssetImage(ImageAssets.profile),
                              ),
                            ),
                            // Positioned(
                            //   right: 2,
                            //   child: Container(
                            //     height:35,
                            //     width: 35,
                            //     decoration: BoxDecoration(
                            //       shape: BoxShape.circle,
                            //       color: Colors.green,
                            //     ),
                            //     child: IconButton(
                            //         onPressed: () {}, icon:Icon(Icons.camera_alt,color: AppColors.black,size: 20,) ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        top: 87,
                        right: 24,
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 23),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppString.fullName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      color: ThemeAppCubit.get(context).IsDark
                                          ?AppColors.white
                                          : AppColors.darkcontiner,
                                    ),
                                  ),
                                  Text(
                                    cubit!.data!.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      color: ThemeAppCubit.get(context).IsDark
                                          ? Colors.white54
                                          : AppColors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                              height: 1,
                              color: AppColors.grey.withOpacity(.7),
                              thickness: 1),
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 23, top: 23),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppString.email,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.5,
                                      fontFamily: 'Poppins',
                                      color: ThemeAppCubit.get(context).IsDark
                                          ? AppColors.white
                                          : AppColors.darkcontiner,
                                    ),
                                  ),
                                  Text(
                                    cubit.data!.email,
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
                            ),
                          ),

                          //about mono
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 500,
                    )
                  ],
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
