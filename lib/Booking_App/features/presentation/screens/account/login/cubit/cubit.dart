import 'package:booking_app/Booking_App/features/data/models/login_model.dart';
import 'package:booking_app/Booking_App/features/data/repositories/repository.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/account/login/cubit/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LogInStates> {
  final Repository repository;

  LoginCubit({
    required this.repository,
  }) : super(InitialLogInStates());

  static LoginCubit get(context) => BlocProvider.of(context);



  LoginModel? loginModel;

  void userLogin({required String email, required String password}) async {
    emit(UserLoginLoadingState());

    final response = await repository.login(
      email: email,
      password: password,
    );

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        loginModel = r;
        print("--------------------LoginToken--${loginModel!.data!.token}");
        emit(UserLoginSuccessState(loginModel: r));
      },
    );
  }

  IconData suffix = Icons.visibility;
  bool isPass = true;

  void ChangePasswordVisibility() {
    isPass = !isPass;
    suffix = isPass ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordVisibilityState());
  }
}
