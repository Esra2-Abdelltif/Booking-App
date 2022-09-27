import 'package:booking_app/Booking_App/Core/di/injection.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/config/themes/cubit/cubit.dart';
import 'package:booking_app/Booking_App/config/themes/cubit/states.dart';
import 'package:booking_app/Booking_App/config/themes/dark_themes.dart';
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
  dynamic IsDark =CacheHelper.getDate(key: 'IsDark');


  print(onBoarding);

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        IsDark: (IsDark != null) ? IsDark : false ,
        StartScreen: RightScreen,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget? StartScreen;
  final bool IsDark;
  // bool onBoarding;
  const MyApp({Key? key, this.StartScreen,required this.IsDark}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (context) => sl<AppBloc>()..userProfile(),
        ),
        BlocProvider(create: (BuildContext context )=>ThemeAppCubit()..ChangeAppMode(fromShared: IsDark)),

      ],
      child:BlocConsumer<ThemeAppCubit,ThemeAppStates>(
        listener: (themecontext,state){},
        builder: (themecontext ,state){
          return
            MaterialApp(
              title: AppString.appTitle,
              theme: lightthemes..bottomNavigationBarTheme,
              darkTheme: darkthemes..bottomNavigationBarTheme,
              themeMode: ThemeAppCubit.get(themecontext).IsDark ? ThemeMode.dark:ThemeMode.light ,
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
            );
        },
      ),
    );
  }
}
