import 'package:booking_app/Booking_App/features/data/models/status_model.dart';

class CreateBookingModel{
  final StatusBookingModel status;
  CreateBookingModel({
    required this.status,
});

  factory CreateBookingModel.fromJson(Map<String,dynamic> json){
    return CreateBookingModel(
      status: StatusBookingModel.fromJson(json['status']),
    );
  }
}

class StatusBookingModel{
  final String type;
  final String messageAr;
  final String messageEn;
  final int bookingId;

  StatusBookingModel({
    required this.type,
    required this.messageAr,
    required this.messageEn,
    required this.bookingId,
  });

  factory StatusBookingModel.fromJson(Map<String, dynamic> json) {
    return StatusBookingModel(
      type: json['type']??'0',
      messageAr: json['title'] != null ? json['title']['ar']??'empty' : 'empty',
      messageEn: json['title'] != null ? json['title']['en']??'empty' : 'empty',
      bookingId: json['booking_id'],
    );
  }
}