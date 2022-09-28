
import 'package:booking_app/Booking_App/features/data/models/hotel_model..dart';
import 'package:booking_app/Booking_App/features/data/models/searcHotel_model.dart';
import 'package:booking_app/Booking_App/features/data/models/searcHotels_model.dart';
import 'package:booking_app/Booking_App/features/data/repositories/repository.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  final Repository repository;

  SearchCubit({
    required this.repository,
  }) : super( InitialSearchStates()) ;
  static SearchCubit get(context) => BlocProvider.of<SearchCubit>(context);


  List<SearchHotelModel> hotelsBySearch = [];

  void searchHotels({required String hotelName,String? address} ) async {
    emit(SearchLoadingState());

    final response = await repository.searchHotels(
      page: 1,
      hotelName:hotelName ,
      address: address,
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




  List<SearchHotelModel> hotels = [];

  void getHotels({String? address}) async {
    emit(HotelsLoadingState());
    final response = await repository.getFilterHotels(
      page: 1,
      address:address,
    );

    response.fold(
          (l) {
        emit(SearchErrorState(exception: l));
      },
          (r) {
            hotels = r.data!.data;

        emit(HotelsSuccessState());
      },
    );
  }


  List<Facilities> facilities = [];

  void getFacilitiesHotels({String? name,required int id}) async {
    emit(FacilitiesLoadingState());
    final response = await repository.getfacilitiesHotels(
      page: 1,
      name: name,
      id: id,
    );

    response.fold(
          (l) {
        emit(SearchErrorState(exception: l));
      },
          (r) {
            facilities = r.facilities;

        emit(FetfacilitiesSuccessState());
      },
    );
  }


}




