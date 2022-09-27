import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/trips_widget.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  @override
  void initState() {
    AppBloc.get(context).getBookings();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: AppBloc.get(context).completed.length != 0
                ? TripsWidget(
                    model: AppBloc.get(context).completed,
                    buttonWidget: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text(
                          'Finished',
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
                          'Revisit your favorite places',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              fontSize: 22),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Here you\'ll find all past trips and inspiration',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'for your next ones.',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  )
          );
        });
  }
}
