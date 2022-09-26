
import 'package:booking_app/Booking_App/Core/di/injection.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/Core/utilites/assets_manager.dart';
import 'package:booking_app/Booking_App/Core/utilites/validator.dart';
import 'package:booking_app/Booking_App/config/themes/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/data/datasources/local/cacheHelper.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/account/login/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/account/login/cubit/state.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/app_layout.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/CustomTextButton.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/customButton.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/custromTextForm.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/show_toast.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  bool _isPass = true;

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    return BlocProvider(
        create: (BuildContext context) => sl<LoginCubit>(),
        child: BlocConsumer<LoginCubit, LogInStates>(
            listener: (BuildContext context,  state) {
              if(state is UserLoginSuccessState)
              {
                  showToastMsg(massage: state.loginModel.status.messageEn ,
                      state: ToastState.SUCCESS,
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG);
                  CacheHelper.saveDate(key: 'token', value: state.loginModel.data!.token).then((value)  {
                   // token =  state.loginModel.data!.token;
                    navigateAndFinsh(context: context,router: AppLayout());
                  });

              }
              if(state is LoginErrorState){
                showToastMsg(massage: state.exception.error,
                    state: ToastState.ERROR,
                    gravity: ToastGravity.BOTTOM,
                    toastLength: Toast.LENGTH_LONG);
              }

            },
            builder: (BuildContext context,   state) {
              return Scaffold(
                appBar: AppBar(
                  title:Text(
                    AppString.loginNow,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: ThemeAppCubit.get(context).IsDark?AppColors.white : AppColors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                  body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,vertical: 50
                        ),
                        child: Container(
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Icon(Icons.person,size: 50,color: Colors.blue,),
                                Image.asset(ImageAssets.user,fit: BoxFit.cover,color: Colors.blue,),
                                 SizedBox(height: 10,),
                                 Text(
                                    AppString.loginNowDiscription,
                                    style:  TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: ThemeAppCubit.get(context).IsDark?Colors.white : AppColors.grey,
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
                                   textAlign: TextAlign.center,
                                 ),
                                const SizedBox(
                                  height: 40,
                                ),
                                CustomTextFormFiled(
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                      color: ThemeAppCubit.get(context).IsDark?AppColors.white : AppColors.grey
                                  ),
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  labeltext:   AppString.emailAdress,
                                  //hintText: AppString.enterEmailAdress,
                                  obscureText: !_isPass,
                                  prefix: const Icon(
                                    Icons.email,
                                    color: AppColors.defultColor,
                                  ),
                                  validation: emailField,
                                  color: AppColors.blueColor,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomTextFormFiled(
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                      color: ThemeAppCubit.get(context).IsDark?AppColors.white : AppColors.grey
                                  ),
                                  controller: passController,
                                  type: TextInputType.text,
                                  labeltext: AppString.password,
                                 // hintText: AppString.enterPassword,
                                  obscureText: LoginCubit.get(context).isPass,
                                  onSubmited: (value) {
                                    if (formkey.currentState!.validate()) {
                                      if (formkey.currentState!.validate()){
                                        print('---------------------------------------${passController.text}');
                                        LoginCubit.get(context).userLogin(email: emailController.text, password:passController.text);

                                      }
                                    }
                                  },
                                  prefix: const Icon(
                                    Icons.lock,
                                    color: AppColors.defultColor,
                                  ),
                                  suffix: LoginCubit.get(context).suffix,
                                  suffixFun: () {
                                    LoginCubit.get(context).ChangePasswordVisibility();
                                  },
                                  color: AppColors.blueColor,
                                  validation: validatePassword,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ConditionalBuilder(
                                  condition: state is! UserLoginLoadingState,
                                  builder: (context) =>  CustomButton(
                                      borderColor: AppColors.blueColor,
                                      text: AppString.login,
                                      onTap: () {
                                        if (formkey.currentState!.validate()){
                                          print(passController.text);
                                          LoginCubit.get(context).userLogin(email: emailController.text, password:passController.text);

                                         // AppConstance.navigateTo(router:HomeScreen(),context: context);
                                        }
                                      }),
                                  fallback: (context) => CircularProgressIndicator(),
                                ),

                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                     Text(AppString.dontHaveAnAccount,
                                        style:  TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          color: ThemeAppCubit.get(context).IsDark?AppColors.white : Color(0xFF8D8E98),
                                        )),
                                    CustomTextButton(
                                      textcolor: AppColors.defultColor,
                                      text: AppString.signUp,
                                      onPressed: () {
                                        AppConstance.navigateTo(
                                            router: const RegisterScreen(), context: context);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                 );
            }
        )
    );
  }
}
