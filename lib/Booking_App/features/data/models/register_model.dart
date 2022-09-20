import 'package:booking_app/Booking_App/features/data/models/status_model.dart';
import 'package:booking_app/Booking_App/features/data/models/user_model.dart';

class RegisterModel{
  StatusModel status;
  UserModel data;

  RegisterModel({
    required this.status,
    required this.data,
});
  factory RegisterModel.fromJson(Map<String,dynamic> json){
    return RegisterModel(
     status:StatusModel.fromJson(json['status']) ,
      data:UserModel.fromJson(json['data']) ,
    );
  }
}
