import 'package:booking_app/Booking_App/Core/utilites/helper.dart';
import 'package:booking_app/Booking_App/Core/utilites/localfiles.dart';
import 'package:booking_app/Booking_App/config/themes/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../Core/utilites/app_colors.dart';
import '../../data/models/getBooking_model.dart';
import '../../data/models/hotel_list.dart';
import '../../data/models/hotel_model..dart';
import '../../data/models/user_model.dart';

class TripsWidget extends StatelessWidget {
  final Container buttonWidget;
  final Widget popUp;
  List<DataModel> model;
  HotelListData hotelListData = HotelListData();

  TripsWidget(
      {Key? key,
      required this.buttonWidget,
      required this.model,
      required this.popUp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppBloc.get(context);
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppBloc.get(context);
        return ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                      elevation: 2,
                      shadowColor: ThemeAppCubit.get(context).IsDark
                          ? Colors.grey.shade900
                          : Colors.grey.shade200,
                      color: ThemeAppCubit.get(context).IsDark
                          ? AppColors.darkcontiner
                          : AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.16,
                        color: ThemeAppCubit.get(context).IsDark
                            ? AppColors.darkcontiner
                            : AppColors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                                //${HotelListData.hotelList[index].imagePath}
                                image: AssetImage("${HotelListData.hotelList[index].imagePath}"),
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.width * 0.35,
                                fit: BoxFit.fill),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${model[index].hotel!.name}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                        color: ThemeAppCubit.get(context).IsDark
                                            ? AppColors.white
                                            : AppColors.black,
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('${model[index].hotel!.description}',
                                      style: TextStyle(fontSize: 24).copyWith(
                                          color: Colors.grey,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400)),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        size: 16,
                                        color: AppColors.defultColor,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "${model[index].hotel!.address}",
                                        style: TextStyle(
                                            color: AppColors.grey,
                                            fontFamily: 'Poppins',
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating: double.parse(
                                                '${model[index].hotel!.rate}') /
                                            2,
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: AppColors.yellow,
                                        ),
                                        itemCount: 5,
                                        itemSize: 18.0,
                                        unratedColor:
                                            AppColors.grey.withOpacity(.7),
                                        direction: Axis.horizontal,
                                      ),
                                      Text(
                                        '(${double.parse('${model[index].hotel!.rate}') / 2})',
                                        style: TextStyle(
                                            color: AppColors.grey,
                                            fontSize: 10,
                                            fontFamily: 'Poppins'),
                                      ),
                                      SizedBox(
                                        width: 70,
                                      ),
                                      model[index].type != 'cancelled' &&
                                              model[index].type != 'completed'
                                          ? PopupMenuButton(
                                              icon: const Icon(
                                                Icons.more_horiz,
                                                color: Colors.grey,
                                              ),
                                              itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      value: 1,
                                                      child: Row(
                                                        children: const [
                                                          Icon(Icons.task_alt,
                                                              color:
                                                                  Colors.teal),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text("Completed")
                                                        ],
                                                      ),
                                                      onTap: () {
                                                        AppBloc.get(context)
                                                            .updateBookingCompleted(
                                                                bookingId: AppBloc
                                                                        .get(
                                                                            context)
                                                                    .upcomming[
                                                                        index]
                                                                    .id);
                                                      },
                                                    ),
                                                    PopupMenuItem(
                                                      value: 2,
                                                      child: Row(
                                                        children: const [
                                                          Icon(
                                                            Icons
                                                                .cancel_outlined,
                                                            color: Colors.red,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text("Cancelled")
                                                        ],
                                                      ),
                                                      onTap: () {
                                                        AppBloc.get(context)
                                                            .updateBookingCancelled(
                                                                bookingId: AppBloc
                                                                        .get(
                                                                            context)
                                                                    .upcomming[
                                                                        index]
                                                                    .id);
                                                      },
                                                    ),
                                                  ])
                                          : Container(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            );
          },
          itemCount: model.length,
        );
      },
    );
  }
}
