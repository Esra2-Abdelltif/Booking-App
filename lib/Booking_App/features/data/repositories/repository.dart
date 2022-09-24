
import 'package:booking_app/Booking_App/Core/error/exceptions.dart';
import 'package:booking_app/Booking_App/features/data/datasources/remote/dio_helper.dart';
import 'package:booking_app/Booking_App/features/data/datasources/remote/end_points.dart';
import 'package:booking_app/Booking_App/features/data/models/hotels_model..dart';
import 'package:booking_app/Booking_App/features/data/models/login_model.dart';
import 'package:booking_app/Booking_App/features/data/models/profile_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

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
  Future<Either<PrimaryServerException, ProfileModel>> updatePofile({
    required String token,
    required String name,
    required String email,
  });
  Future<Either<PrimaryServerException, HotelsModel>> getHotels({
    required int page,
  });
  Future<Either<PrimaryServerException, HotelsModel>> searchHotels({
    required int page,
    required String hotelName,
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
  })async{
    return await basicErrorHandling<RegisterModel>(
        onSuccess: ()async {
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
        onPrimaryServerException: (e)async{
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
          'name':hotelName,
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
    required String name,
    required String email,
  }) async {
    return basicErrorHandling<ProfileModel>(
      onSuccess: () async {
        final response = await dioHelper.post(
          endPoint: profileUpdateEndPoint,
          token: token,
          data: {
            'email': email,
            'name': name,
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