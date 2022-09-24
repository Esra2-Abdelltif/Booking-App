import 'package:booking_app/Booking_App/Core/utilites/helper.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Core/utilites/app_colors.dart';
import '../../data/models/hotel_list.dart';

class TripsWidget extends StatelessWidget {
  final Widget buttonWidget;
  final Color favoiriteColor;
  HotelListData hotelListData = HotelListData();

  TripsWidget(
      {Key? key, required this.buttonWidget, required this.favoiriteColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=AppBloc.get(context);
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 18, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image(
                      image: AssetImage('assests/images/city_5.jpg'),
                      fit: BoxFit.cover,
                      width: 310,
                      height: 168,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.white.withOpacity(0.7),
                        ),
                        child: Icon(
                          Icons.favorite_border_rounded,
                          color: favoiriteColor,
                          // size: 20,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${cubit.hotels[6].name}',
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "${cubit.hotels[6].price}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blueColor,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "${cubit.hotels[6].description}",
                style: TextStyle(
                    fontSize: 10,
                    color: AppColors.fontColorGrey,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 17,
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(hotelListData.imagePath),
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child:Helper.ratingStar()
                    ),
                    buttonWidget
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
