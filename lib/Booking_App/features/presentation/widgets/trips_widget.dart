import 'package:booking_app/Booking_App/Core/utilites/helper.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      {Key? key, required this.buttonWidget,required this.model,required this.popUp})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    var cubit = AppBloc.get(context);
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=AppBloc.get(context);
        return
          ListView.builder(itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.19,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                                '${model[index].hotel!.name}',
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
                                    "${model[index].hotel?.price}",
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
                            "${model[index].hotel!.description}",
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
                                buttonWidget,
                                model[index].type!='cancelled' && model[index].type!='completed'?
                                PopupMenuButton(
                                    icon: const Icon(
                                      Icons.more_horiz,
                                      color: Colors.grey,
                                    ),
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: 1,
                                        child: Row(
                                          children: const [
                                            Icon(Icons.task_alt, color: Colors.teal),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Completed")
                                          ],
                                        ),
                                        onTap: () {
                                          AppBloc.get(context).updateBookingCompleted(bookingId:AppBloc.get(context).upcomming[index].id);
                                        },
                                      ),
                                      PopupMenuItem(
                                        value: 2,
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.red,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Cancelled")
                                          ],
                                        ),
                                        onTap: () {
                                          AppBloc.get(context).updateBookingCancelled(bookingId: AppBloc.get(context).upcomming[index].id);
                                        },
                                      ),
                                    ]):Container(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(height: 0.5,width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.grey
                          ),
                        ),
                      ],
                    ),

                  ),

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
