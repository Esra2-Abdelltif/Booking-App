import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/config/themes/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/data/models/hotel_list.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/hotel_details/hotel_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:math' as math;
import '../../../widgets/imageSlider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, index) {},
      builder: (context, index) {
        var cubit = AppBloc.get(context);
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: ImageSlider(
                    maxExtent: height / 1.6,
                    minExtent: 280,
                  )),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 36.0, left: 16.0,bottom: 16,right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          AppString.best_Deals,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                      Text(
                        "View all ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppColors.blueColor,
                        ),
                      ),
                      Icon(Icons.arrow_forward,color: AppColors.blueColor,size: 12,)
                    ],
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 8.0, left: 8.0, bottom: 8),
                      child: InkWell(
                        onTap: () {
                          AppConstance.navigateTo(
                            context: context,
                            router: HotelDetails(
                              imagePath: 'http://api.mahmoudtaha.com/images/${AppBloc.get(context).hotels[index].images[math.Random().nextInt(AppBloc.get(context).hotels[index].images.length)]}',
                              hotelid: cubit.hotels[index].id,
                              longitude: cubit.hotels[index].longitude,
                              latitude: cubit.hotels[index].latitude ,
                              hotelName: cubit.hotels[index].name,
                              adresse: cubit.hotels[index].address,
                              description: cubit.hotels[index].description,
                              price: cubit.hotels[index].price,
                              rate: cubit.hotels[index].rate,
                            ),
                          );

                          print(cubit.hotels[index].id);
                        },
                        child: Card(
                          elevation: 2,
                          shadowColor:ThemeAppCubit.get(context).IsDark
                              ?   Colors.grey.shade900
                              : Colors.grey.shade200,
                          color: ThemeAppCubit.get(context).IsDark? AppColors.darkcontiner : AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(16),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.16,
                            color: ThemeAppCubit.get(context).IsDark ? AppColors.darkcontiner : AppColors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                    image: NetworkImage(
                                        'http://api.mahmoudtaha.com/images/${AppBloc.get(context).hotels[index].images[math.Random().nextInt(AppBloc.get(context).hotels[index].images.length)]}' ),
                                    width: MediaQuery.of(context).size.width*0.33,
                                    height: MediaQuery.of(context).size.height*0.35,
                                    fit: BoxFit.fill),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8.0, top: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width:230,
                                            child: Text(
                                              cubit.hotels[index].name,
                                            overflow: TextOverflow.ellipsis,
                                            //   textAlign: TextAlign.justify,
                                            //   softWrap: false,
                                            //   maxLines: 1,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins',
                                                  color: ThemeAppCubit.get(context).IsDark
                                                      ? AppColors.white
                                                      : AppColors.black,
                                                  fontSize: 17),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .location_pin,
                                            size: 16,
                                            color: AppColors
                                                .defultColor,
                                          ),
                                          SizedBox(width: 8,),
                                          Row(
                                            children: [
                                              Container(
                                                width:200,
                                                child: Text(
                                                  cubit.hotels[index].address,
                                                    overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppColors.grey,
                                                      fontFamily: 'Poppins',
                                                      fontSize:15 ),
                                                ),
                                              ),
                                            ],
                                          ),




                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [

                                         SizedBox(width: 170,),
                                          Text(
                                            '\$${cubit.hotels[index].price}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins',
                                                fontSize: 17
                                            ),
                                          ),




                                        ],
                                      ),

                                      Row(
                                        children: [
                                          RatingBarIndicator(
                                            rating: double.parse(
                                                '${cubit.hotels[index].rate}') /
                                                2,
                                            itemBuilder: (context, index) => Icon(
                                              Icons.star,
                                              color: AppColors.yellow,
                                            ),
                                            itemCount: 5,
                                            itemSize: 20.0,
                                            unratedColor:
                                            AppColors.grey.withOpacity(.7),
                                            direction: Axis.horizontal,
                                          ),
                                          Text(
                                            '(${double.parse('${cubit.hotels[index].rate}') / 2})',
                                            style: TextStyle(
                                                color:  AppColors.grey,
                                                fontSize: 10,
                                                fontFamily: 'Poppins'
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),

                                          Text(
                                            '/per night',
                                            style: TextStyle(
                                                color:  AppColors.grey,
                                                fontSize: 12,
                                                fontFamily: 'Poppins'
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }, childCount: cubit.hotels.length))
            ],
          ),
        );
      },
    );
  }
}