import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../data/models/hotel_list.dart';

class RatingView extends StatefulWidget {
  HotelListData hotelListData = HotelListData();

  RatingView({required this.hotelListData});

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  @override
  Widget build(BuildContext context) {
    var rating = widget.hotelListData.rating;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      (widget.hotelListData.rating * 2).toStringAsFixed(1),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.teal,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Overall Rating',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Theme.of(context).disabledColor),
                          ),
                          SmoothStarRating(
                            allowHalfRating: false,
                            starCount: 5,
                            rating: rating,
                            size: 16.0,
                            color: Colors.teal,
                            borderColor: Colors.teal,
                            spacing: 0.0,
                            onRatingChanged: (v) {
                              setState(() {
                                rating = v;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              getBarUi('Room', 95.0, context),
              SizedBox(
                height: 4,
              ),
              getBarUi('Services', 80.0, context),
              SizedBox(
                height: 4,
              ),
              getBarUi('Location', 65.0, context),
              SizedBox(
                height: 4,
              ),
              getBarUi('Price', 85.0, context),
            ],
          ),
        ),
      ),
    );
  }

  getBarUi(String text, double percent, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: Theme.of(context).disabledColor.withOpacity(0.8),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: percent.toInt(),
                child: Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: SizedBox(
                    height: 4,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(8)),
                      child: Card(),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 100 - percent.toInt(),
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
