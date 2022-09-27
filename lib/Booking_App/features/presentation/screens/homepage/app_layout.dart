
import 'package:booking_app/Booking_App/Core/di/injection.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLayout extends StatelessWidget {
  late final String title;
  var scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (BuildContext context) =>sl<AppBloc>()..userProfile()..getHotels(),
        child: BlocConsumer<AppBloc,AppStates>(
            listener: (BuildContext context,AppStates state)
            {
            },
            builder: (BuildContext context ,AppStates state)
            {
              AppBloc cubit =  AppBloc.get(context);
              return Scaffold(
                key: scaffoldKey,
                body:  Column(
                  children: [
                    Expanded(child: cubit.screens[cubit.currentIndex]),


                  ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  items: cubit.bottomNavigation,
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.ChangeIndex(index);
                  },
                ),


              );
            }

        )
    );
  }
}
