import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaterialButton(
              onPressed: () {
                // AppBloc.get(context).userLogin();
              },
              child: const Text('Login'),
            ),
            MaterialButton(
              onPressed: () {
                // AppBloc.get(context).userProfile();
              },
              child: const Text('Get Profile'),
            ),
            MaterialButton(
              onPressed: () {
                //AppBloc.get(context).getHotels();
              },
              child: const Text('Get Hotels'),
            ),
            MaterialButton(
              onPressed: () {
                //AppBloc.get(context).getHotels();
              },
              child: const Text('Get Hotels'),
            ),
            MaterialButton(
              onPressed: () {
                //AppBloc.get(context).getHotels();
              },
              child: const Text('test'),
            ),
          ],
        ),

    );
  }
}
