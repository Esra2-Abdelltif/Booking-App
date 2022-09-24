import 'package:flutter/material.dart';

import '../../../widgets/trips_widget.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TripsWidget(
      buttonWidget: MaterialButton(
        onPressed: () {},
        color: Colors.red,
        child: Text('finished'),
      ),
      favoiriteColor: Colors.red,
    ));
  }
}
