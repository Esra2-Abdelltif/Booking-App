import 'package:booking_app/Booking_App/features/data/datasources/remote/dio_helper.dart';
import 'package:booking_app/Booking_App/features/data/repositories/repository.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/presentation/screens/account/login/cubit/cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AppBloc(
    repository: sl(),
  ));
  sl.registerFactory(() => LoginCubit(
    repository: sl(),
  ));

  sl.registerLazySingleton<DioHelper>(
        () => DioImpl(),
  );

  sl.registerLazySingleton<Repository>(
        () => RepositoryImplementation(
      dioHelper: sl(),
    ),
  );
}