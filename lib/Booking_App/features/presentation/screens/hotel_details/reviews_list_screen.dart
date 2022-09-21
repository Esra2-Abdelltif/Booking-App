import 'package:booking_app/Booking_App/features/presentation/screens/hotel_details/reviews_view.dart';
import 'package:flutter/material.dart';

import '../../../data/models/hotel_list.dart';

class ReviewsListScreen extends StatefulWidget {
  static const String routeName = 'reviews';

  const ReviewsListScreen({Key? key}) : super(key: key);

  @override
  State<ReviewsListScreen> createState() => _ReviewsListScreenState();
}

class _ReviewsListScreenState extends State<ReviewsListScreen>
    with TickerProviderStateMixin {
  List<HotelListData> reviewsList = HotelListData.reviewsList;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close)),
        title: Text(
          'Reviews',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                    top: 8, bottom: MediaQuery.of(context).padding.bottom + 8),
                itemBuilder: (_, index) {
                  var count = reviewsList.length > 10 ? 10 : reviewsList.length;
                  var animation = Tween(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController.forward();
                  return ReviewsView(
                    callback: () {},
                    reviewList: reviewsList[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
                itemCount: reviewsList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
