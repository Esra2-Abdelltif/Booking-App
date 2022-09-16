import 'package:booking_app/utilites/app_strings.dart';
import 'package:booking_app/utilites/assets_manager.dart';

class BoardingModel {
  String image;
  String title;
  String discription;

  BoardingModel({required this.image, required this.title, required this.discription});
}

List<BoardingModel> contents = [
  BoardingModel(
      title: AppString.onBoardingTitle1,
      image: ImageAssets.onBoarding1,
      discription:  AppString.onBoardingdiscription1
  ),
  BoardingModel(
      title:  AppString.onBoardingTitle2,
      image: ImageAssets.onBoarding2,
      discription: AppString.onBoardingdiscription2

  ),
  BoardingModel(
      title:  AppString.onBoardingTitle3,
      image: ImageAssets.onBoarding3,
      discription: AppString.onBoardingdiscription3,
  ),
];