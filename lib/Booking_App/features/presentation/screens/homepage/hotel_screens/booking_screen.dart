import 'package:flutter/material.dart';

import '../../../widgets/trips_widget.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TripsWidget(
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
                    color: Colors.white, fontFamily: 'Poppins', fontSize: 12),
              ),
            ),
          ),
        ));
  }
}
