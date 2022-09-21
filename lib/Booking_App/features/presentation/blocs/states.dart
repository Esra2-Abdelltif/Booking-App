


import 'package:booking_app/Booking_App/Core/error/exceptions.dart';
import 'package:booking_app/Booking_App/features/data/models/profile_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}
class AppChangeBottomNavBarState extends AppStates {}
class UserProfileLoadingState extends AppStates {}
class UserProfileSuccessState extends AppStates {
  final ProfileModel profileModel;

  UserProfileSuccessState({required this.profileModel});
}
class UserUpdateProfileLoadingStates extends AppStates{}
class  UserUpdateProfileSuccessState extends AppStates{
  ProfileModel? profileModel;

  UserUpdateProfileSuccessState({required this.profileModel});
}



class HotelsLoadingState extends AppStates {}

class HotelsSuccessState extends AppStates {}

class ErrorState extends AppStates {
  final PrimaryServerException exception;

  ErrorState({
    required this.exception,
  });
}