import 'package:booking_app/Booking_App/features/presentation/screens/account/register/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/register_model.dart';
import '../../../../../data/repositories/repository.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  final Repository repository;

  RegisterCubit({
    required this.repository,
  }) : super(InitialRegisterStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility;
  bool isPass = true;

  void ChangePasswordVisibility() {
    isPass = !isPass;
    suffix = isPass ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordRegisterVisibilityState());
  }

  RegisterModel? registerModel;
  void register({required String name, required String email,required String password, required String confirmPassword}) async {
    emit(UserRegisterLoadingState());
    final response = await repository.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    response.fold(
          (l) {
        emit(RegisterErrorState(exception: l));
      },
          (r) {
        registerModel=r;
        emit(UserRegisterSuccessState());
      },
    );
  }
}
