

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class Helper{
  static Widget ratingStar({double rating = 4.5}) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.teal,
      ),
      itemCount: 5,
      unratedColor: Colors.grey,
      itemSize: 18.0,
      direction: Axis.horizontal,
    );
  }
}