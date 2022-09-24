import 'package:booking_app/Booking_App/Core/error/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class SearchStates {
  const SearchStates();
}

class InitialSearchStates extends SearchStates {}
class  SearchLoadingState extends SearchStates {}
class  SearchSuccessState extends SearchStates {

}

class SearchErrorState extends SearchStates {
  final PrimaryServerException exception;

  SearchErrorState({
    required this.exception,
  });
}


