import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/splash/splash.dart';
import 'package:flutter/material.dart';

import '../../features/presentation/screens/onboarding/onBoarding_screen.dart';


class Routes {
  static const String initialRoute = '/';
  static const String onBoeardingRoute = '/onBoeardingRoute';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) {
          return  SplashScreen();
        });

      case Routes.onBoeardingRoute:
        return MaterialPageRoute(builder: ((context) {
          return  OnBoardinScreen();
        }));
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
          body: Center(
            child: Text(AppString.noRouteFound),
          ),
        )));
  }
}
