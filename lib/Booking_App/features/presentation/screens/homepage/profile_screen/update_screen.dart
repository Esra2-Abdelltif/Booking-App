
import 'package:booking_app/Booking_App/Core/di/injection.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/Core/utilites/assets_manager.dart';
import 'package:booking_app/Booking_App/Core/utilites/validator.dart';
import 'package:booking_app/Booking_App/config/themes/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/home_screen/home_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/profile_screen/profile_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/profile_screen/update_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/customButton.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/custom_appBar_view.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/custromTextForm.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/show_toast.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpDateScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  bool _isPass = true;

  UpDateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    return  BlocProvider(
        create: (BuildContext context) =>sl<AppBloc>()..userProfile(),
        child: BlocConsumer<AppBloc, AppStates>(
          listener: (BuildContext context, state) {
            if (state is UserUpdateProfileSuccessState) {
              showToastMsg(
                  massage: state.profileModel!.status.messageEn,
                  state: ToastState.SUCCESS,
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_LONG);
            }
            if (state is ErrorState) {
              showToastMsg(
                  massage: state.exception.error,
                  state: ToastState.ERROR,
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_LONG);
            }
          },
          builder: (context, state) {
            AppBloc cubit = AppBloc.get(context);
            nameController.text = '${cubit.profileModel?.data?.name}'  ;
            emailController.text = '${cubit.profileModel?.data?.email}';

            return Scaffold(
                body: ConditionalBuilder(
                  condition: AppBloc.get(context).profileModel != null,
                  builder: (context) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonAppbarView(
                        iconData: Icons.arrow_back,
                        onBackClick: () {
                          // Navigator.of(context, rootNavigator: false).push(MaterialPageRoute(
                          //     builder: (context) => ProfileScreen(), maintainState: false));
                          AppConstance.navigatePop(context: context);
                          // AppConstance.navigateTo(context: context,router: ProfileScreen());
                          AppBloc.get(context).userProfile();
                          AppBloc.get(context).userProfile();

                        },
                        titleText: AppString.updateProfile,
                        onTap: () {
                          AppBloc.get(context).userProfile();
                        },
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                            child: Form(
                              key: formkey,
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
                                            radius: 80,
                                            backgroundColor: AppColors.yellow,
                                            child: CircleAvatar(
                                              radius: 77,
                                              backgroundColor: AppColors.white,
                                              backgroundImage:
                                              AssetImage(ImageAssets.userProfile),
                                            ),
                                          ),
                                          Positioned(
                                            right: 2,
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.green,
                                              ),
                                              child: IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.camera_alt,
                                                    color: AppColors.black,
                                                    size: 20,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 24,
                                      top: 50,
                                      right: 24,
                                    ),
                                    child: Column(
                                      children: [
                                        CustomTextFormFiled(
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              color: ThemeAppCubit.get(context).IsDark?AppColors.white : AppColors.grey
                                          ),
                                          controller: nameController,
                                          type: TextInputType.text,
                                          labeltext: AppString.fullName,
                                          //hintText: AppString.enterName,
                                          obscureText: !_isPass,
                                          prefix: const Icon(
                                            Icons.person,
                                            color: AppColors.defultColor,
                                          ),
                                          validation: userNameField,
                                          color: AppColors.defultColor,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        CustomTextFormFiled(
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              color: ThemeAppCubit.get(context).IsDark?AppColors.white : AppColors.grey
                                          ),
                                          controller: emailController,
                                          type: TextInputType.emailAddress,
                                          labeltext: AppString.emailAdress,
                                          //hintText: AppString.enterEmailAdress,
                                          obscureText: !_isPass,
                                          prefix: const Icon(
                                            Icons.email,
                                            color: AppColors.defultColor,
                                          ),
                                          validation: emailField,
                                          color: AppColors.defultColor,
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 50),
                                          child: CustomButton(
                                              borderColor: AppColors.blueColor,
                                              text: AppString.updateProfile,
                                              onTap: () {
                                                if (formkey.currentState!.validate()) {
                                                  AppBloc.get(context).updateUserData(name: nameController.text, email: emailController.text);
                                                  AppBloc.get(context).userProfile();
                                                }
                                              }),
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
                            ),
                          )),
                    ],
                  ),
                  fallback: (context) => Center(child: CircularProgressIndicator()),
                ));
          },
        ),
    );
  }
}
