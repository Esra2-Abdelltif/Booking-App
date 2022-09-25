
import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/hotel_screens/booking_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/hotel_screens/cancelled_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/hotel_screens/completed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotleScreen extends StatelessWidget {
  var ScaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc,AppStates>(
        listener: (BuildContext context,AppStates state)
        {
        },
        builder: (BuildContext context ,AppStates state)
        {
          AppBloc cubit =  AppBloc .get(context);
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              key: ScaffoldKey,
              appBar: AppBar(
                centerTitle: true,
                leading:  InkWell(
                    onTap: () => AppConstance.navigatePop(context: context),
                    child:Icon(Icons.arrow_back_ios)
                ),
                title:Text("Hotel",
                    style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
               
                bottom: TabBar(
                  tabs: cubit.tabs,
                  labelColor:AppColors.blueColor,
                  unselectedLabelColor:AppColors.grey,
                  indicatorColor: AppColors.blueColor,
                  indicatorWeight: 1.5,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
              body:   Column(
                children: [

                  Padding(

                    padding: const EdgeInsets.only(left: 24,right: 24,bottom: 28),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: AppColors.grey,width: .5))
                      ),

                    ),
                  ),
                  //Screens
                  Expanded(
                    child: TabBarView(
                      children: [
                        BookingScreen(),
                        CancelledScreen(),
                        CompletedScreen(),

                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          );
        }

    );
  }
}
