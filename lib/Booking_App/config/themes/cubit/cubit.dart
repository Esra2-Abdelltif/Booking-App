import 'package:bloc/bloc.dart';
import 'package:booking_app/Booking_App/config/themes/cubit/states.dart';
import 'package:booking_app/Booking_App/features/data/datasources/local/cacheHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeAppCubit extends Cubit<ThemeAppStates>
{
  ThemeAppCubit() : super(InitialThemeAppState());
  static  ThemeAppCubit get(context) => BlocProvider.of(context);

  bool IsDark=false;
  void ChangeAppMode({ bool? fromShared}){
    if(fromShared != null) {
      IsDark = fromShared;
      emit(AppChangeModeState());
    }
    else {
      IsDark = !IsDark;
      CacheHelper.putDate(key: 'IsDark', value: IsDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }




}
