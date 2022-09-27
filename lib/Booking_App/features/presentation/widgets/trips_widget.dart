import 'package:booking_app/Booking_App/Core/utilites/helper.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Core/utilites/app_colors.dart';
import '../../data/models/getBooking_model.dart';
import '../../data/models/hotel_list.dart';

class TripsWidget extends StatelessWidget {
  final Container buttonWidget;
  final Container popUp;
  List<DataModel> model;
  HotelListData hotelListData = HotelListData();

  TripsWidget(
      {Key? key, required this.buttonWidget,required this.model,required this.popUp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppBloc.get(context);
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.grey.withOpacity(0.2),),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.19,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image(
                        image: AssetImage('assests/images/city_5.jpg'),
                        fit: BoxFit.cover,
                        width: 310,
                        height: 168,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${cubit.hotels[6].name}',
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                "\$",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                              Text(
                                "${cubit.hotels[6].price}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              )
                            ],
                          )

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${cubit.hotels[6].description}",
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(child: Helper.ratingStar()),
                            buttonWidget
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),


                   /* Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.white.withOpacity(0.7),
                        ),
                        *//* child: Icon(
                        Icons.favorite_border_rounded,
                        color: favoiriteColor,
                        // size: 20,
                      ),*//*
                      ),
                    ),*/
                  ],
                ),

              ),

            ],
          ),
        );
      },
    );
  }
}
