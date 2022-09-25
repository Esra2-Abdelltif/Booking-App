import 'package:booking_app/Booking_App/config/themes/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/account/login/login_screen_.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/account/register/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../Core/di/injection.dart';
import '../../../../../Core/utilites/app_colors.dart';
import '../../../../../Core/utilites/app_constance.dart';
import '../../../../../Core/utilites/app_strings.dart';
import '../../../../../Core/utilites/validator.dart';
import '../../../widgets/CustomTextButton.dart';
import '../../../widgets/customButton.dart';
import '../../../widgets/custromTextForm.dart';
import '../../../widgets/show_toast.dart';
import '../login/cubit/state.dart';
import 'cubit/cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var confirmPassController = TextEditingController();
    var formkey = GlobalKey<FormState>();
    bool _isPass = true;
    return BlocProvider(
      create: (BuildContext context) => sl<RegisterCubit>(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
      listener: (context,state){
        if(state is UserRegisterSuccessState){
          showToastMsg(massage: RegisterCubit.get(context).registerModel!.status.messageEn ,
              state: ToastState.SUCCESS,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG);
          AppConstance.navigateTo(
              router: LoginScreen(), context: context);
        }
        if(state is RegisterErrorState){
          showToastMsg(massage: state.exception.error,
              state: ToastState.ERROR,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG);
        }
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text(AppString.signUp,style: TextStyle(
              fontFamily: 'Poppins'
            ),),
          ),
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
                          Image.asset('assests/images/add_user.png',fit: BoxFit.fill,color: Colors.blue,),
                          SizedBox(height: 20,),
                          CustomTextFormFiled(
                            style:TextStyle(
                              fontFamily: 'Poppins',
                                fontSize: 12,
                                color: ThemeAppCubit.get(context).IsDark?AppColors.white : AppColors.grey
                            ),
                            controller: nameController,
                            type: TextInputType.text,
                            labeltext:   AppString.fullName,
                            //hintText: AppString.enterName,
                            obscureText: !_isPass,
                            prefix: const Icon(
                              Icons.person,
                              color: AppColors.defultColor,
                            ),
                            validation: userNameField,
                            color: AppColors.defultColor,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormFiled(
                            style:TextStyle(
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
                            color: AppColors.defultColor,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormFiled(
                            style:TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: ThemeAppCubit.get(context).IsDark?AppColors.white : AppColors.grey
                            ),
                            controller: passController,
                            type: TextInputType.visiblePassword,
                            labeltext: AppString.password,
                            //hintText: AppString.enterPassword,
                            obscureText: RegisterCubit.get(context).isPass,
                            prefix: const Icon(
                              Icons.lock,
                              color: AppColors.defultColor,
                            ),
                            suffix: RegisterCubit.get(context).suffix,
                            suffixFun: () {
                              RegisterCubit.get(context).ChangePasswordVisibility();
                            },
                            color: AppColors.defultColor,
                            validation: validatePassword,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormFiled(
                            style:TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: ThemeAppCubit.get(context).IsDark?AppColors.white : AppColors.grey
                            ),
                            controller: confirmPassController,
                            type: TextInputType.visiblePassword,
                            labeltext: AppString.confirmPassword,
                            //hintText: AppString.enterConfirmPassword,
                            obscureText: RegisterCubit.get(context).isPass,
                            onSubmited: (value) {
                              if (formkey.currentState!.validate()) {
                                if (formkey.currentState!.validate()){
                                  print('---------------------------------------${passController.text}');
                                  RegisterCubit.get(context).register(name: nameController.text, email: emailController.text
                                      , password: passController.text, confirmPassword: confirmPassController.text);

                                }
                              }
                            },
                            prefix: const Icon(
                              Icons.lock,
                              color: AppColors.defultColor,
                            ),
                            suffix: RegisterCubit.get(context).suffix,
                            suffixFun: () {
                              RegisterCubit.get(context).ChangePasswordVisibility();
                            },
                            color: AppColors.defultColor,
                            validation: validateRepeatPassword,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! UserLoginLoadingState,
                            builder: (context) =>  CustomButton(
                                borderColor: AppColors.blueColor,
                                text: AppString.signUp,
                                onTap: () {
                                  if (formkey.currentState!.validate()){
                                    print(passController.text);
                                    RegisterCubit.get(context).register(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passController.text,
                                        confirmPassword: confirmPassController.text,
                                    );
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
                               Text(AppString.haveAnAccount,
                                  style:  TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: ThemeAppCubit.get(context).IsDark?AppColors.white : AppColors.grey,
                                  )),
                              CustomTextButton(
                                textcolor: AppColors.defultColor,
                                text: AppString.login,
                                onPressed: () {
                                  AppConstance.navigateTo(
                                      router: LoginScreen(), context: context);
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
      },
    ),
    );
  }
}
