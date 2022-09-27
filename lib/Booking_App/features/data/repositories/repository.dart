
import 'package:booking_app/Booking_App/Core/error/exceptions.dart';
import 'package:booking_app/Booking_App/features/data/datasources/remote/dio_helper.dart';
import 'package:booking_app/Booking_App/features/data/datasources/remote/end_points.dart';
import 'package:booking_app/Booking_App/features/data/models/hotels_model..dart';
import 'package:booking_app/Booking_App/features/data/models/login_model.dart';
import 'package:booking_app/Booking_App/features/data/models/profile_model.dart';
import 'package:booking_app/Booking_App/features/data/models/status_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../models/createBooking_model.dart';
import '../models/getBooking_model.dart';
import '../models/hotel_model..dart';
import '../models/register_model.dart';




abstract class Repository {
  Future<Either<PrimaryServerException, LoginModel>> login({
    required String email,
    required String password,
  });

  Future<Either<PrimaryServerException,RegisterModel>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<Either<PrimaryServerException, ProfileModel>> getProfile({
    required String token,
  });
  Future<Either<PrimaryServerException, GetBooking>> getBooking({
    required String token,
    required String type,
    required int count,
  });
  Future<Either<PrimaryServerException, ProfileModel>> updatePofile({
    required String token,
    required String? name,
    required String? email,
  });
  Future<Either<PrimaryServerException, StatusModel>> updateBooking({
    required int bookingId,
    required String type,
  });
  Future<Either<PrimaryServerException, HotelsModel>> getHotels({
    required int page,
  });
  Future<Either<PrimaryServerException, HotelsModel>> searchHotels({
    required int page,
    required String hotelName,
  });

Future<Either<PrimaryServerException, CreateBookingModel>> createBooking({
  required int hotelId,
  required int userId,
  required String token,
});
}


class RepositoryImplementation extends Repository {
  final DioHelper dioHelper;

  RepositoryImplementation({
    required this.dioHelper,
  });

  @override
  Future<Either<PrimaryServerException, RegisterModel>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    return await basicErrorHandling<RegisterModel>(
        onSuccess: () async {
          final response = await dioHelper.post(
            endPoint: registerEndPoint,
            data: {
              'name': name,
              'email': email,
              'password': password,
              'password_confirmation': confirmPassword,
            },
          );
          return RegisterModel.fromJson(response);
        },
        onPrimaryServerException: (e) async {
          return e;
        }
    );
  }

  @override
  Future<Either<PrimaryServerException, HotelsModel>> getHotels({
    required int page,
  }) async {
    return basicErrorHandling<HotelsModel>(
      onSuccess: () async {
        final response = await dioHelper.get(
            endPoint: hotelsEndPoint,
            query: {
              'page': page,
              'count': 10,
            }
        );

        return HotelsModel.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }

  @override
  Future<Either<PrimaryServerException, HotelsModel>> searchHotels({
    required int page,
    required String hotelName,

  }) async {
    return basicErrorHandling<HotelsModel>(
      onSuccess: () async {
        final response = await dioHelper.get(endPoint: searchEndPoint, query: {
          'page': page,
          'count': 10,
          'name': hotelName,
        });

        return HotelsModel.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }


  @override
  Future<Either<PrimaryServerException, ProfileModel>> getProfile({
    required String token,
  }) async {
    return basicErrorHandling<ProfileModel>(
      onSuccess: () async {
        final response = await dioHelper.get(
          endPoint: profileEndPoint,
          token: token,
        );

        return ProfileModel.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }


  @override
  Future<Either<PrimaryServerException, ProfileModel>> updatePofile({
    required String token,
    required String? name,
    required String? email,
  }) async {
    return basicErrorHandling<ProfileModel>(
      onSuccess: () async {
        final response = await dioHelper.post(
          endPoint: profileUpdateEndPoint,
          token: token,
          data: {
            'email': email ,
            'name': name ,
          },
        );

        return ProfileModel.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }


  @override
  Future<Either<PrimaryServerException, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    return basicErrorHandling<LoginModel>(
      onSuccess: () async {
        final response = await dioHelper.post(
          endPoint: loginEndPoint,
          data: {
            'email': email,
            'password': password,
          },
        );

        return LoginModel.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }

  @override
  Future<Either<PrimaryServerException, CreateBookingModel>> createBooking({
    required int hotelId,
    required int userId,
    required String token,
  }) async {
    return basicErrorHandling<CreateBookingModel>(
        onSuccess: () async {
          final response = await dioHelper.post(
            endPoint: createBookingEndPoint,
            data: {
              'hotel_id': hotelId,
              'user_id': userId,
            },
            token: token,
          );
          return CreateBookingModel.fromJson(response);
        },
        onPrimaryServerException: (e) async {
          return e;
        }
    );
  }

  @override
  Future<Either<PrimaryServerException, GetBooking>> getBooking({
    required String token,
    required String type,
    required int count,
  }) async {
    return basicErrorHandling<GetBooking>(
      onSuccess: () async {
        final response = await dioHelper.get(
            endPoint: getBookingEndPoint,
            token: token,
            query: {
              'type': type,
              'count': count,
            }
        );

        return GetBooking.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }

  @override
  Future<Either<PrimaryServerException, StatusModel>> updateBooking({
    required int bookingId,
    required String type,
  }) async {
    return basicErrorHandling<StatusModel>(
      onSuccess: () async {
        final response = await dioHelper.post(
            endPoint: updateBookingEndPoint,
          data: {
            'booking_id':bookingId,
            'type': type,
          }
        );
        return
        StatusModel.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }
}

extension on Repository {
  Future<Either<PrimaryServerException, T>> basicErrorHandling<T>({
    required Future<T> Function() onSuccess,
    Future<PrimaryServerException> Function(PrimaryServerException exception)?
    onPrimaryServerException,
  }) async {
    try {
      final r = await onSuccess();
      return Right(r);
    } on PrimaryServerException catch (e, s) {
      return Left(e);
    }
  }
}