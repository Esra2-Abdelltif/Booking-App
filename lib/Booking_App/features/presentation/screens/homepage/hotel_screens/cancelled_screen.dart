import 'package:booking_app/Booking_App/features/presentation/widgets/trips_widget.dart';
import 'package:flutter/material.dart';

class CancelledScreen extends StatelessWidget {
  const CancelledScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TripsWidget(
      buttonWidget: MaterialButton(
        color: Colors.blue,
        onPressed: () {},
        child: Text('Cancelled'),
      ),
      favoiriteColor: Colors.blue,
    ));
  }
}
