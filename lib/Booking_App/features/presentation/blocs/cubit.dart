import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/features/data/datasources/local/cacheHelper.dart';
import 'package:booking_app/Booking_App/features/data/models/hotel_model..dart';
import 'package:booking_app/Booking_App/features/data/models/profile_model.dart';
import 'package:booking_app/Booking_App/features/data/repositories/repository.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/home_screen/home_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/hotel_screens/hotel_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/profile_screen/profile_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/settings_screens/settings_screen.dart';
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

  void ChangeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  List<BottomNavigationBarItem> bottomNavigation = [
     BottomNavigationBarItem(
        icon: Icon(Icons.home, size: 24), label: AppString.home),
     BottomNavigationBarItem(
        icon: const Icon(Icons.hotel, size: 24), label: AppString.hotel),
     BottomNavigationBarItem(
        icon: const Icon(Icons.person, size: 24), label: AppString.profile),
     BottomNavigationBarItem(
        icon: Icon(Icons.settings, size: 24), label: AppString.settings),
  ];

  List<Widget> screens = [
    HomeScreen(),
    HotleScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];
  TabController? tabController;

  List<Tab> tabs = [
    const Tab(
      text: AppString.booking,
    ),
    const Tab(
      text: AppString.cancelled,
    ),
    const Tab(
      text: AppString.completed,
    ),
  ];

  ProfileModel? profileModel;

  void userProfile() async {
    emit(UserProfileLoadingState());
    final response = await repository.getProfile(
      token: CacheHelper.getDate(key: 'token'),
    );
    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        profileModel = r;

        emit(UserProfileSuccessState(profileModel: r));
      },
    );
  }

  void updateUserData({required String name, required String email}) async {
    emit(UserUpdateProfileLoadingStates());
    final response = await repository.updatePofile(
        email: email, token: CacheHelper.getDate(key: 'token'), name: name);
    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        profileModel = r;
        emit(UserUpdateProfileSuccessState(profileModel: r));
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
