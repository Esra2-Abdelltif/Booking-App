import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/features/data/datasources/local/cacheHelper.dart';
import 'package:booking_app/Booking_App/features/data/models/createBooking_model.dart';
import 'package:booking_app/Booking_App/features/data/models/hotel_model..dart';
import 'package:booking_app/Booking_App/features/data/models/profile_model.dart';
import 'package:booking_app/Booking_App/features/data/models/status_model.dart';
import 'package:booking_app/Booking_App/features/data/repositories/repository.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/home_screen/home_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/hotel_screens/hotel_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/profile_screen/profile_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/settings_screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;

import '../../../Core/utilites/app_constance.dart';
import '../../data/models/getBooking_model.dart';

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
        icon: Icon(Icons.miscellaneous_services_sharp, size: 24),
        label: AppString.settings),
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

  void updateUserData({required String? name, required String? email}) async {
    emit(UserUpdateProfileLoadingStates());
    final response = await repository.updatePofile(
        email: email, token: CacheHelper.getDate(key: 'token'),
        name: name
    );
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

  List<DataModel> completed = [];
  List<DataModel> upcomming  = [];
  List<DataModel> cancelled  = [];


  void getBookings() async {
    emit(getBookingLoadingState());

    final response = await repository.getBooking(
        token: CacheHelper.getDate(key: 'token'),
        type: 'completed',
        count:10,
    );

    response.fold(
          (l) {

        emit(ErrorState(exception: l));
      },
          (r) {
        completed = r.data!.data!;

        emit(getBookingSuccessState());
      },
    );
  }
  void getBookingCancelled() async {
    emit(getCancelledLoadingState());

    final response = await repository.getBooking(
      token: CacheHelper.getDate(key: 'token'),
      type: 'cancelled',
      count: 10,
    );

    response.fold(
          (l) {
        emit(ErrorState(exception: l));
      },
          (r) {
        cancelled = r.data!.data!;

        emit(getCancelledSuccessState());
      },
    );
  }
  void getBookingsUpComming() async {
    emit(getUpCommingLoadingState());

    final response = await repository.getBooking(
      token: CacheHelper.getDate(key: 'token'),
      type: 'upcomming ',
      count: 10,
    );

    response.fold(
          (l) {
            print('==================================${l.message}');
        emit(ErrorState(exception: l));
      },
          (r) {
        upcomming = r.data!.data!;

        emit(getUpCommingSuccessState());
      },
    );
  }

  CreateBookingModel? bookingModel;

  void createBooking({
  required int hotelId,
  required int userId,
})async{
    emit(CreateBookingLoadingState());
    final response=await  repository.createBooking(
        hotelId: hotelId,
        userId:userId ,
      token: CacheHelper.getDate(key: 'token'),
    );
    response.fold(
            (l) {
              emit(ErrorState(exception: l));
            },
            (r) {
              bookingModel=r;
              print(r.status!.title?.en);
              print(r.status!.bookingId);
              print(token);
              emit(CreateBookingSuccessState());
            });
  }


  StatusModel? update;
  void updateBookingCancelled({required dynamic bookingId})async{
    emit(updateCancelledLoadingState());
    final response= await repository.updateBooking(
      bookingId:bookingId,
      type: 'cancelled',
    );
    response.fold(
          (l) {
        emit(ErrorState(exception: l));
      },
          (r) {
            update = r;
            getBookingsUpComming();
        print(r.messageEn);
        //print(bookingModel!.status!.bookingId);
        emit(updateCancelledSuccessState());
      },
    );
  }
  void updateBookingCompleted({required dynamic bookingId})async{
    emit(updateCancelledLoadingState());
    final response= await repository.updateBooking(
      bookingId:bookingId,
      type: 'completed',
    );
    response.fold(
          (l) {
        emit(ErrorState(exception: l));
      },
          (r) {
        update = r;
        getBookingsUpComming();
        print(r.messageEn);
        //print(bookingModel!.status!.bookingId);
        emit(updateCancelledSuccessState());
      },
    );
  }
}
