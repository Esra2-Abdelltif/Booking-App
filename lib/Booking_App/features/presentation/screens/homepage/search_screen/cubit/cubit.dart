
import 'package:booking_app/Booking_App/features/data/models/facitities_model.dart';
import 'package:booking_app/Booking_App/features/data/models/hotel_model..dart';
import 'package:booking_app/Booking_App/features/data/models/searcHotel_model.dart';
import 'package:booking_app/Booking_App/features/data/models/searcHotels_model.dart';
import 'package:booking_app/Booking_App/features/data/repositories/repository.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  final Repository repository;

  SearchCubit({
    required this.repository,
  }) : super( InitialSearchStates()) ;
  static SearchCubit get(context) => BlocProvider.of<SearchCubit>(context);

//search by name
  List<SearchHotelModel> hotelsBySearch = [];

  void searchHotels({required String hotelName} ) async {
    emit(SearchLoadingState());

    final response = await repository.searchHotels(
      page: 1,
      hotelName:hotelName ,

    );

    response.fold(
          (l) {
        emit(SearchErrorState(exception: l));
      },
          (r) {
        hotelsBySearch = r.data!.data;

        emit(SearchSuccessState());
      },
    );
  }

  bool isEnd = false;

  void toggleIsEnd() {
    isEnd = !isEnd;

    emit(ToggleIsEndState());
  }

//Get Data of Hotel
  List<SearchHotelModel> hotels = [];
  int lastPage = 1;
  int total = 0;
  int currentPage = 1;
  void getHotels({ bool isForce = false,}) async {
    emit(HotelsLoadingState());
    if(isForce) {
      hotels = [];
      currentPage = 1;
    }

    final response = await repository.getExploerHotels(
      page: currentPage,

    );
    response.fold(
          (l) {
        emit(SearchErrorState(exception: l));
      },
          (r) {
            hotels.addAll(r.data!.data);
            currentPage++;
            if(lastPage == 1) {
              lastPage = r.data!.lastPage;
              total = r.data!.total;
            }

            isEnd = false;

        emit(HotelsSuccessState());
      },
    );
  }


  FacilitiesModel? facilitiesModel;

  void getFacilities() async {
    emit(GetFacilitiesLoadingState());

    final response = await repository.getFacilities();

    response.fold(
          (l) {
        emit(SearchErrorState(exception: l));
      },
          (r) {
        facilitiesModel = r;

        emit(GetFacilitiesSuccessState());
      },
    );
  }

  List<int> selectedFacilities = [];

  void selectFacility(int id) {
    if (selectedFacilities.contains(id)) {
      selectedFacilities.remove(id);
    } else {
      selectedFacilities.add(id);
    }

    emit(SelectFacilityState());
  }

  TextEditingController searchController = TextEditingController();

  SearchModel? searchHotelsModel;

  void  searchByFacilitiesHotels() async {
    emit(SearchLoadingState());

    final response = await repository. searchByFacilitiesHotels(
      name: searchController.text.isEmpty ? '' : searchController.text,
      facilities: {
        ...selectedFacilities.asMap().map(
              (key, value) => MapEntry(
            'facilities[$key]',
            value,
          ),
        ),
      },
    );

    response.fold(
          (l) {
        emit(SearchErrorState(exception: l));
      },
          (r) {
        searchHotelsModel = r;

        emit(SearchSuccessState());
      },
    );
  }




}







