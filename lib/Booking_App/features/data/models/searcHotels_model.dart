import 'package:booking_app/Booking_App/features/data/models/searcHotel_model.dart';
import 'package:booking_app/Booking_App/features/data/models/status_model.dart';

class SearchModel {
  final StatusModel status;
  final SearchHotelsModel? data;
  SearchModel({
    required this.status,
    required this.data,
  });



  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
    status : StatusModel.fromJson(json['status']),
    data : SearchHotelsModel.fromJson(json['data']),
    );
  }
}

class SearchHotelsModel {
  final List<SearchHotelModel> data;
  final int lastPage;
  final int total;
  SearchHotelsModel({
    required this.data,
    required this.lastPage,
    required this.total,
  });

  factory SearchHotelsModel.fromJson(Map<String, dynamic> json) {
    return SearchHotelsModel(
      data: List<SearchHotelModel>.from(
        json['data'].map(
          (x) => SearchHotelModel.fromJson(x),
        ),
      ),
      total: json['total'],
      lastPage: json['last_page'],


    );
  }
}

