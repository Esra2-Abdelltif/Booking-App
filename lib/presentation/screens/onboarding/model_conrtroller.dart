import 'package:booking_app/utilites/assets_manager.dart';

class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Plan Your Trips',
      image: ImageAssets.onBoarding1,
      discription: "Book one of your unique hotels to escape the ordinary "
  ),
  UnbordingContent(
      title: 'Find Best Deals',
      image: ImageAssets.onBoarding2,
      discription: "Find deals for any season from cosy country home to city flats  "

  ),
  UnbordingContent(
      title: 'Best Traveling All Time',
      image: ImageAssets.onBoarding3,
      discription: "Find deals for any season from cosy country home to city flats "
  ),
];