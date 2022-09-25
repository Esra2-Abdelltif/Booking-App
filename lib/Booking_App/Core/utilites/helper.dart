import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class Helper {
  static Widget ratingStar({double rating = 4.5}) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=AppBloc.get(context);
        return RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, index) =>
              Icon(
                Icons.star,
                color: AppColors.yellow,
              ),
          itemCount: 5,
          unratedColor: Colors.grey,
          itemSize: 18.0,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
