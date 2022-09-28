
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

    final response = await repository.getFilterHotels(
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



  bool isEnd = false;

  void toggleIsEnd() {
    isEnd = !isEnd;

    emit(ToggleIsEndState());
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
        facilities = r.data!.data[0].facilities;

        emit(FetfacilitiesSuccessState());
      },
    );
  }

}







