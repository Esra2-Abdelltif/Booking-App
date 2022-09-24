
import 'package:booking_app/Booking_App/features/data/models/hotel_model..dart';
import 'package:booking_app/Booking_App/features/data/repositories/repository.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  final Repository repository;

  SearchCubit({
    required this.repository,
  }) : super( InitialSearchStates()) ;
  static SearchCubit get(context) => BlocProvider.of<SearchCubit>(context);


  List<HotelModel> hotels = [];

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
        hotels = r.data!.data;

        emit(SearchSuccessState());
      },
    );
  }
}




