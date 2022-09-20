import '../../../../../../Core/error/exceptions.dart';

abstract class RegisterStates {}

class InitialRegisterStates extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final PrimaryServerException exception;

  RegisterErrorState({
    required this.exception,
  });
}

class ChangePasswordRegisterVisibilityState extends RegisterStates {}

class UserRegisterLoadingState extends RegisterStates {}
class UserRegisterSuccessState extends RegisterStates {}