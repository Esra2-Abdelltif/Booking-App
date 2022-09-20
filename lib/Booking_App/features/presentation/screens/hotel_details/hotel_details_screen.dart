import 'package:booking_app/Booking_App/features/data/models/hotel_list.dart';
import 'package:flutter/material.dart';

class HotelDetails extends StatefulWidget {
  late final HotelListData hotelListData;
  static const String routeName = 'home-details';

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails>
    with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);
  var hotelText =
      'Featuring a fitness center , Grand royal parking hotel is located in egypt , 4.7 km from giza ...';
  var hotelText2 =
      'Featuring a fitness center , Grand royal parking hotel is located in egypt , 4.7 km from giza a fitness center';
  bool isFav = false;
  bool isReadless = false;

  late AnimationController animationController;
  var imageHeight = 0.0;

  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _animationController =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);
    animationController.forward();
    scrollController.addListener(() {
      if (mounted) {
        if (scrollController.offset < 0) {
          //we static set the just below half scrolling values
          _animationController.animateTo(0.0);
        } else if (scrollController.offset > 0.0 &&
            scrollController.offset < imageHeight) {
          //we need around half scrolling values
          if (scrollController.offset < ((imageHeight / 1.2))) {
            _animationController
                .animateTo(scrollController.offset / imageHeight);
          } else {
            //we static set the just above half scrolling values "around == 0.22"
            _animationController.animateTo((imageHeight / 1.2) / imageHeight);
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    imageHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          (Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.only(top: 24 + imageHeight),
              children: [
                Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Container(
                  height:AppBar().preferredSize.height ,
                  child: Row(
                    children: [
                      _getAppBarUi(Theme.of(context).disabledColor.withOpacity(0.4),
                          Icons.arrow_back, Theme.of(context).backgroundColor,(){ })

                    ],
                  ),
                ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  getHotelsDetails({required bool isInList}) {}
}

_getAppBarUi(Color color, IconData icon, Color iconColor,VoidCallback onTap) {
 return SizedBox(
   height:AppBar().preferredSize.height ,
   child: Padding(
     padding: EdgeInsets.only(top: 8,left: 8 ,right: 8),
   ),
 );
}
