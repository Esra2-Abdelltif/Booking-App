import 'package:booking_app/Booking_App/features/data/models/hotel_list.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/common_card.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/list_cell_animation_view.dart';
import 'package:flutter/material.dart';

class ReviewsView extends StatelessWidget {
  final VoidCallback callback;

  final HotelListData reviewList;

  final AnimationController animationController;

  final Animation<double> animation;

  const ReviewsView(
      {Key? key,
      required this.callback,
      required this.reviewList,
      required this.animationController,
      required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
        animation: animation,
        animationController: animationController,
        yTranslation: 40,
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, top: 16),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 48,
                  child: CommonCard(
                    radius: 8,
                    color: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8.0),),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(reviewList.imagePath,fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reviewList.titleTxt,style: TextStyle(
                      fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                  ),
                  Row(
                    children: [
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
