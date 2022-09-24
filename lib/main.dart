import 'package:booking_app/Booking_App/Core/di/injection.dart';
import 'package:booking_app/Booking_App/config/themes/light_theme.dart';
import 'package:booking_app/Booking_App/features/data/datasources/local/cacheHelper.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/map/map_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/splash/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:booking_app/observer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  await CacheHelper.init();
  Widget? RightScreen;
  dynamic onBoarding = CacheHelper.getDate(key: 'onBoarding');
  dynamic appToken = CacheHelper.getDate(key: 'token');

  print(onBoarding);

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        StartScreen: RightScreen,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget? StartScreen;

  const MyApp({Key? key, this.StartScreen}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (context) => sl<AppBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightthemes,
        debugShowCheckedModeBanner: false,
       home: SplashScreen(),
        routes: {
          MapScreen.routeName:(_)=>MapScreen(),
        },


       /* localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English, no country code
          Locale('ar'), // Spanish, no country code
        ],
        locale: Locale('en'),*/
      ),
    );
  }
}
