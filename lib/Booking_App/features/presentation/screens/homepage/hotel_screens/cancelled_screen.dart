import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/trips_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelledScreen extends StatefulWidget {
  const CancelledScreen({Key? key}) : super(key: key);

  @override
  State<CancelledScreen> createState() => _CancelledScreenState();
}

class _CancelledScreenState extends State<CancelledScreen> {
  @override
  void initState() {
    AppBloc.get(context).getBookingCancelled();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body:state is! ErrorState
              ?  TripsWidget(
                  model: AppBloc.get(context).cancelled,
                  buttonWidget: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        'Cancelled',
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
                        'Sometimes plans change',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            fontSize: 22),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Here you\'ll see all the trips you\'ve canceled.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Maybe next time!',
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
