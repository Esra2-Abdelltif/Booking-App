
import 'package:booking_app/Booking_App/Core/di/injection.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/Core/utilites/validator.dart';
import 'package:booking_app/Booking_App/features/data/datasources/local/cacheHelper.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/account/login/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/account/login/cubit/state.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/home.dart';
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
                if(state.loginModel.status.type == "1" )
                {
                  showToastMsg(massage: state.loginModel.status.messageEn ,
                      state: ToastState.SUCCESS,
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG);
                  CacheHelper.saveDate(key: 'token', value: state.loginModel.data!.token).then((value)  {
                   // token =  state.loginModel.data!.token;
                    navigateAndFinsh(context: context,router: HomeScreen());
                  });
                }
                else{
                  print("****************************************${state.loginModel.status.messageEn}");

                  showToastMsg(massage: state.loginModel.status.messageEn ,
                      state: ToastState.ERROR,
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG);
                }
              }


            },
            builder: (BuildContext context,   state) {
              return Scaffold(
                  body: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: Container(
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                   AppString.loginNow,
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                    AppString.loginNowDiscription,
                                    style:  TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color:  Color(0xFF8D8E98),
                                    )),
                                const SizedBox(
                                  height: 40,
                                ),
                                CustomTextFormFiled(
                                  style: Theme.of(context).textTheme.bodyText2,
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  labeltext:   AppString.emailAdress,
                                  hintText: AppString.enterEmailAdress,
                                  obscureText: !_isPass,
                                  prefix: const Icon(
                                    Icons.email,
                                    color: AppColors.defultColor,
                                  ),
                                  validation: emailField,
                                  color: AppColors.defultColor,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomTextFormFiled(
                                  style: Theme.of(context).textTheme.bodyText2,
                                  controller: passController,
                                  type: TextInputType.text,
                                  labeltext: AppString.password,
                                  hintText: AppString.enterPassword,
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
                                  color: AppColors.defultColor,
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
                                    const Text(AppString.dontHaveAnAccount,
                                        style:  TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Color(0xFF8D8E98),
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
                  ));
            }
        )
    );
  }
}
