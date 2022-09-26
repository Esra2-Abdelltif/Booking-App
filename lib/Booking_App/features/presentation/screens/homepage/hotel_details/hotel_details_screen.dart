import 'dart:async';
import 'dart:ui';

import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/helper.dart';
import 'package:booking_app/Booking_App/features/data/models/hotel_list.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/hotel_details/hotel_room_list.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../config/themes/cubit/cubit.dart';
import '../../map/map_screen.dart';

class HotelDetails extends StatefulWidget {
  int hotelid;
  final String hotelName;
  final String description;
  final String adresse;
  final dynamic price;
  final String rate;

  HotelDetails(
      {required this.hotelid,
      required this.hotelName,
      required this.description,
      required this.adresse,
      required this.price,
      required this.rate});

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

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

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
                    color: ThemeAppCubit.get(context).IsDark?Colors.white54:AppColors.grey,
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
                              color: ThemeAppCubit.get(context).IsDark? AppColors.white:AppColors.black,
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
                              color: ThemeAppCubit.get(context).IsDark?Colors.white54:AppColors.grey),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: !isReadless ? 'read more' : '' + 'less',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: AppColors.blueColor),
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
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      padding: EdgeInsetsDirectional.only(start: 14, end: 14),
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, top: 10),
                      child: FloatingActionButton.extended(
                        backgroundColor: Colors.grey.withOpacity(0.6),
                        onPressed: () {
                          Navigator.pushNamed(context, MapScreen.routeName);
                        },
                        label: Text('see more'),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(top: 24, bottom: 14),
                  padding: EdgeInsetsDirectional.only(start: 24, end: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: AppColors.blueColor,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      //booking room
                    },
                    child: Text(
                      'Book Now',
                      style: TextStyle(
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
          backgroundImageUi('assests/images/hotel_5.png'),
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
                /*  _getAppBarUi(
                      Colors.white,
                      isFav ? Icons.favorite : Icons.favorite_border,
                      Theme.of(context).primaryColor, () {
                    setState(() {
                      isFav = !isFav;
                    });
                  })*/
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
                                              color:AppColors.blueColor,
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

  getHotelsDetails({
    bool isInList = false,
  }) {
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
                widget.hotelName,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: ThemeAppCubit.get(context).IsDark ? AppColors.white : Colors.black,
                    fontSize: 18),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.adresse,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                        color: ThemeAppCubit.get(context).IsDark ? AppColors.white : Colors.black,
                        fontSize: 11,

                      ),
                    ),
                    Icon(
                      Icons.location_on_sharp,
                      color: AppColors.blueColor,
                      size: 13,
                    ),
                    Text(
                      //"${widget.hotelListData.dist.toStringAsFixed(1)}",
                      '2.0',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: ThemeAppCubit.get(context).IsDark ? AppColors.white : Colors.black,
                          fontSize: 11),
                    ),
                    Text(
                      'KM To City',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: ThemeAppCubit.get(context).IsDark ? AppColors.white : Colors.black,
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
                          ///
                          //Helper.ratingStar(),
                          RatingBarIndicator(
                            rating:  double.parse('${widget.rate}')/2,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: AppColors.blueColor,

                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            unratedColor:AppColors.grey.withOpacity(.7),
                            direction: Axis.horizontal,
                          ),
                          Text(
                            '(${double.parse('${widget.rate}') / 2})',
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Poppins',
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
              '\$${widget.price}',
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
                color:ThemeAppCubit.get(context).IsDark
                    ? AppColors.white
                    : AppColors.black,
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
                          color: ThemeAppCubit.get(context).IsDark
                              ? AppColors.blueColor
                              : AppColors.blueColor,),
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

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
