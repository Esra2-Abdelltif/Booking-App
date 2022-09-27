import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../widgets/show_toast.dart';
import '../../../widgets/trips_widget.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    AppBloc.get(context).getBookingsUpComming();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {
        if(state is updateCancelledSuccessState){
          showToastMsg(massage: 'successfully updated',
              state: ToastState.SUCCESS,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG);
        }
      },
      builder: (context, state) {
        return
        Scaffold(
          body: state is! ErrorState
              ?
            TripsWidget(
                  model: AppBloc.get(context).upcomming,
                  buttonWidget: Container(
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        'Book Now',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 12),
                      ),
                    ),
                  ),
                  popUp: Container(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assests/images/book.png')),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Where to next?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            fontSize: 22),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Can\'t find a booking? Enter your booking',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'details to add it here.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                )
        );
      },
    );
  }
}
