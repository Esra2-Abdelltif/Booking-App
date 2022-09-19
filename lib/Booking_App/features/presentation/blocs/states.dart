


import 'package:booking_app/Booking_App/Core/error/exceptions.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}


class UserProfileLoadingState extends AppStates {}

class UserProfileSuccessState extends AppStates {}

class HotelsLoadingState extends AppStates {}

class HotelsSuccessState extends AppStates {}

class ErrorState extends AppStates {
  final PrimaryServerException exception;

  ErrorState({
    required this.exception,
  });
}