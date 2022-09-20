
import 'package:booking_app/Booking_App/features/data/models/hotel_model..dart';
import 'package:booking_app/Booking_App/features/data/models/login_model.dart';
import 'package:booking_app/Booking_App/features/data/models/profile_model.dart';
import 'package:booking_app/Booking_App/features/data/repositories/repository.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/home_screen/home_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/hotel_screens/hotel_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/profile_screen/profile_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/settings_screens/settings_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;

class AppBloc extends Cubit<AppStates> {
  final Repository repository;

  AppBloc({
    required this.repository,
  }) : super(AppInitialState());

  static AppBloc get(context) => BlocProvider.of<AppBloc>(context);
  int currentIndex = 0;
  void ChangeIndex(int index){
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }

  List<BottomNavigationBarItem> bottomNavigation=  [
    const BottomNavigationBarItem(
        icon:Icon(Icons.home,size: 24), label:"home"),
    const BottomNavigationBarItem(
        icon:const Icon(Icons.hotel,size: 24), label:"hotel"),
    const BottomNavigationBarItem(
        icon:const Icon(Icons.person,size: 24), label:"profile"),
    const BottomNavigationBarItem(
        icon:Icon(Icons.settings,size: 24), label:"settings"),


  ];

  List<Widget> screens = [
     HomeScreen(),
    HotleScreen(),
    const ProfileScreen(),
    const SettingsScreen(),

  ];
  TabController? tabController;

  List<Tab> tabs = [
    const Tab(text:"Booking",),
    const Tab(text:"Cancelled",),
    const Tab(text:"Completed",),

  ];


  LoginModel? loginModel;



  ProfileModel? profileModel;

  void userProfile() async {
    emit(UserProfileLoadingState());

    final response = await repository.getProfile(
      token: loginModel!.data!.token,
    );

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        profileModel = r;

        emit(UserProfileSuccessState());
      },
    );
  }

  List<HotelModel> hotels = [];

  void getHotels() async {
    emit(HotelsLoadingState());

    final response = await repository.getHotels(
      page: 1,
    );

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        hotels = r.data!.data;

        emit(HotelsSuccessState());
      },
    );
  }
}
