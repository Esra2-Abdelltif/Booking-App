import 'package:flutter/material.dart';

import '../../../widgets/trips_widget.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TripsWidget(
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
                color: Colors.white, fontFamily: 'Poppins', fontSize: 12),
          ),
        ),
      ),
    ));
  }
}
