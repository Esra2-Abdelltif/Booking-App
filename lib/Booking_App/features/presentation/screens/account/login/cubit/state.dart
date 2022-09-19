import 'package:booking_app/Booking_App/Core/error/exceptions.dart';
import 'package:booking_app/Booking_App/features/data/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class LogInStates {
  const LogInStates();
}

class InitialLogInStates extends LogInStates {}

class UserLoginLoadingState extends LogInStates {}

class UserLoginSuccessState extends LogInStates {
  final LoginModel loginModel;

  UserLoginSuccessState({required this.loginModel});
}

class ErrorState extends LogInStates {
  final PrimaryServerException exception;

  ErrorState({
    required this.exception,
  });
}

class ChangePasswordVisibilityState extends LogInStates {}
