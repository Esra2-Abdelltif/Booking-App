import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/config/themes/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/hotel_details/hotel_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
                    minExtent: 240,
                  )),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                  child: Text(
                    AppString.best_Deals,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Poppins'),
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
                          hotelid: cubit.hotels[index].id,
                          hotelName: cubit.hotels[index].name,
                          adresse: cubit.hotels[index].adresse,
                          description: cubit.hotels[index].description,
                          price: cubit.hotels[index].price,
                          rate: cubit.hotels[index].rate,
                        ),
                      );

                      print(cubit.hotels[index].id);
                    },
                    child: Card(
                      elevation: 4,
                      //shadowColor: ThemeAppCubit.get(context).IsDark ? AppColors.darkcontiner: AppColors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.16,
                        color: ThemeAppCubit.get(context).IsDark
                            ? AppColors.darkcontiner
                            : AppColors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                                image:
                                    AssetImage('assests/images/hotel_5.png'),
                                width: MediaQuery.of(context).size.width*0.3,
                                height: MediaQuery.of(context).size.width*0.35,
                                fit: BoxFit.fill),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.hotels[index].name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                        color: ThemeAppCubit.get(context).IsDark
                                            ? AppColors.white
                                            : AppColors.black,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    cubit.hotels[index].adresse,
                                    style: TextStyle(
                                        color: ThemeAppCubit.get(context).IsDark
                                            ? AppColors.white
                                            : AppColors.grey,
                                        fontFamily: 'Poppins',
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating: double.parse(
                                                '${cubit.hotels[index].rate}') /
                                            2,
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: AppColors.blueColor,
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
                                            color: ThemeAppCubit.get(context).IsDark
                                                ? AppColors.white
                                                : AppColors.grey,
                                            fontSize: 10,
                                            fontFamily: 'Poppins'
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        '${cubit.hotels[index].price}\$',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                          fontSize: 14
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
