import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/config/themes/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/explore/explore.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/search_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/customButton.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';

class ImageSlider implements SliverPersistentHeaderDelegate{
  final double minExtent;
  final double maxExtent;
  ImageSlider({
    required this.minExtent,
    required this.maxExtent,
});
  List images=[
    'assests/images/slider_1.png',
    'assests/images/slider_2.png',
    'assests/images/slider_3.jpg',
  ];
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    var top=0.0;
   return  Stack(children: [
       CarouselSlider(
         items:images
             .map(
               (e) => Image(image: AssetImage('${e.toString()}'),fit: BoxFit.fill,)
         ).toList(),
         options: CarouselOptions(
           height: maxExtent,
           autoPlay: true,
           autoPlayAnimationDuration: const Duration(seconds: 1),
           autoPlayCurve: Curves.fastOutSlowIn,
           initialPage: 0,
           reverse: false,
           scrollDirection: Axis.horizontal,
           viewportFraction: 1.0,
           autoPlayInterval: const Duration(seconds: 3),
           enableInfiniteScroll: true,
         ),
       ),
       Padding(
         padding: const EdgeInsets.only(top: 80,left: 30,right: 30),
         child: Container(
           width: double.infinity,
           height: 45,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(25),
             color: ThemeAppCubit.get(context).IsDark ? AppColors.darkcontiner: AppColors.white,

           ),
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: InkWell(
               onTap: (){

                 AppConstance.navigateTo(router: SearchScreen(),context: context);
               },
               child: Row(children: [
                 Icon(Icons.search,color: AppColors.defultColor,),
                 Text(AppString.where_are_you_goning,
                     style : TextStyle(fontSize: 24).copyWith(
                         color: Colors.grey,
                         fontSize: 18,
                         fontWeight: FontWeight.w400))
               ],),
             ),
           ),
         ),
       ),
     shrinkOffset >=0 && shrinkOffset<30?
    Padding(
      padding: const EdgeInsets.only(top: 270,left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppString.find_best_deals,style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold,fontFamily: 'Poppins'),),
          SizedBox(height: 5,),
          Text(AppString.extraordinary_five_star,style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'Poppins'),),
          Text(AppString.outdoor_activities,style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'Poppins'),),
          SizedBox(height: 15,),
          CustomButton(borderColor: AppColors.defultColor,height:45 , text: AppString.view_Hotel, onTap: (){
            AppConstance.navigateTo(router: Explore(),context: context);
           SearchCubit.get(context).searchByFacilitiesHotels();


          },width: 120,)
        ],),
    ):
    AnimatedOpacity(
    duration: Duration(milliseconds: 0),
    opacity: top >= 100 ? 1.0 : 0.0,
    child:Padding(
      padding: const EdgeInsets.only(top: 10,left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppString.find_best_deals,style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text(AppString.extraordinary_five_star,style: TextStyle(color: Colors.white,fontSize: 20),),
          Text(AppString.outdoor_activities,style: TextStyle(color: Colors.white,fontSize: 20),),
          SizedBox(height: 15,),
          CustomButton(borderColor: AppColors.defultColor,height:45 , text:AppString.view_Hotel, onTap: (){},width: 120,)
        ],),
    )),

     ],
   );
  }


  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
   return false;
  }

  @override
  // TODO: implement showOnScreenConfiguration
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration => null;

  @override
  // TODO: implement snapConfiguration
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => null;

  @override
  // TODO: implement vsync
  TickerProvider? get vsync => null;

}