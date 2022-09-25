import 'package:booking_app/Booking_App/features/presentation/widgets/trips_widget.dart';
import 'package:flutter/material.dart';

class CancelledScreen extends StatelessWidget {
  const CancelledScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TripsWidget(
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
                color: Colors.white, fontFamily: 'Poppins', fontSize: 12),
          ),
        ),
      ),
    ));
  }
}
