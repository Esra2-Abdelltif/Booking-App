import 'dart:ui';

import 'package:booking_app/Booking_App/Core/utilites/helper.dart';
import 'package:booking_app/Booking_App/Core/utilites/localfiles.dart';
import 'package:booking_app/Booking_App/features/data/models/hotel_list.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/hotel_details/hotel_room_list.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/common_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class HotelDetails extends StatefulWidget {
  HotelListData hotelListData = HotelListData();
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
      'Featuring a fitness center , Grand royal parking hotel is located in egypt , 4.7 km from giza a fitness center ';
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
          Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.only(top: 24 + imageHeight),
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: getHotelsDetails(isInList: true),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Summery',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              letterSpacing: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 24, right: 24, top: 4, bottom: 8),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: !isReadless ? hotelText : hotelText2,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.grey),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: !isReadless ? 'read more' : '' + 'less',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.teal),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                isReadless = !isReadless;
                              });
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                getPhotoReviewUi(
                    'Photos', 'View All', Icons.arrow_forward, () {}),
                HotelRoomList(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: Image.asset(
                        Localfiles.mapImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 34,right: 10),
                    child: CommonCard(
                      color: Theme.of(context).primaryColor,
                      radius: 36,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.pin_drop,
                          color:Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(top: 24,bottom: 14),
                    padding: EdgeInsetsDirectional.only(start: 24,end: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20),),
                      color: Colors.teal.withOpacity(0.5),
                    ),
                    child: MaterialButton(
                      onPressed: (){
                        //booking room
                      },
                      child: Text('Book Now',style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                      ),
                    ),
                  ),

                /*getPhotoReviewUi(
                    'Reviews', 'View All', Icons.arrow_forward, () {
                      Navigator.pushNamed(context, ReviewsListScreen.routeName);
                }),*/
              ],
            ),
          ),
          //background images , hotel names , their details and more animation view
          //backgroundImageUi(widget.hotelListData ?? HotelListData()),
          backgroundImageUi('assests/images/hotel_1.jpg'),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(
              height: AppBar().preferredSize.height,
              child: Row(
                children: [
                  _getAppBarUi(Theme.of(context).disabledColor.withOpacity(0.4),
                      Icons.arrow_back, Theme.of(context).backgroundColor, () {
                    if (scrollController.offset != 0.0) {
                      scrollController.animateTo(0.0,
                          duration: Duration(milliseconds: 488),
                          curve: Curves.easeInOutQuad);
                    } else {
                      Navigator.pop(context);
                    }
                  }),
                  Expanded(
                    child: SizedBox(),
                  ),
                  _getAppBarUi(
                      Colors.white,
                      isFav ? Icons.favorite : Icons.favorite_border,
                      Theme.of(context).primaryColor, () {
                    setState(() {
                      isFav = !isFav;
                    });
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _getAppBarUi(
      Color color, IconData icon, Color iconColor, VoidCallback onTap) {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Padding(
        padding: EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Container(
          width: AppBar().preferredSize.height - 8,
          height: AppBar().preferredSize.height - 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.all(
                Radius.circular(32.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  backgroundImageUi(String image) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            var opacity = 1.0 -
                (_animationController.value >= (imageHeight / 1.2) / imageHeight
                    ? 1.0
                    : _animationController.value);
            return SizedBox(
              height: imageHeight * (1.0 - _animationController.value),
              child: Stack(
                children: [
                  IgnorePointer(
                    child: Container(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            bottom: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset(
                                image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).padding.bottom + 16,
                    left: 0,
                    right: 0,
                    child: Opacity(
                      opacity: opacity,
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .27,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  color: Colors.black54.withOpacity(0.6),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 8, left: 16, right: 16),
                                        child: getHotelsDetails(),
                                      ),
                                      Center(
                                        child: Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.all(24),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.teal.withOpacity(0.8),
                                              borderRadius:
                                                  BorderRadius.circular(32)),
                                          child: MaterialButton(
                                            onPressed: () {
                                              //go to room book screen
                                              //video 22.40 minute
                                            },
                                            child: Text(
                                              'Book Now',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  color: Colors.black54,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      splashColor: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(38)),
                                      onTap: () {
                                        try {
                                          scrollController.animateTo(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      5,
                                              duration:
                                                  Duration(milliseconds: 5000),
                                              curve: Curves.fastOutSlowIn);
                                        } catch (e) {}
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 4,
                                          bottom: 4,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'More Details',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 2),
                                              child: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  getHotelsDetails({bool isInList = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Grand Royal ',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: isInList ? Colors.black : Colors.white,
                    fontSize: 18),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Wembley,London',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: isInList
                              ? Theme.of(context).disabledColor.withOpacity(0.5)
                              : Colors.white,
                          fontSize: 11),
                    ),
                    Icon(
                      Icons.location_on_sharp,
                      color: Colors.teal,
                      size: 13,
                    ),
                    Text(
                      //"${widget.hotelListData.dist.toStringAsFixed(1)}",
                      '2.0',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: isInList
                              ? Theme.of(context).disabledColor.withOpacity(0.5)
                              : Colors.white,
                          fontSize: 11),
                    ),
                    Text(
                      'KM To City',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: isInList
                            ? Theme.of(context).disabledColor.withOpacity(0.5)
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              isInList
                  ? SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Helper.ratingStar(),
                          Text(
                            '${widget.hotelListData.reviews}',
                            style: TextStyle(
                              fontSize: 12,
                              color: isInList
                                  ? Theme.of(context)
                                      .disabledColor
                                      .withOpacity(0.5)
                                  : Colors.white,
                            ),
                          ),
                          Text(
                            'Reviews',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: isInList
                                  ? Theme.of(context)
                                      .disabledColor
                                      .withOpacity(0.5)
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${widget.hotelListData.perNight}',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isInList
                    ? Theme.of(context).textTheme.bodyText1?.color
                    : Colors.white,
              ),
            ),
            Text(
              '/Per Night',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                color: isInList ? Colors.grey : Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  getPhotoReviewUi(
      String title, String view, IconData iconData, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                fontSize: 12,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(
                Radius.circular(4.0),
              ),
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Text(
                      view,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: 38,
                      width: 26,
                      child: Icon(
                        iconData,
                        size: 13,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}