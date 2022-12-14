import 'dart:async';
import 'dart:ui';

import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/helper.dart';
import 'package:booking_app/Booking_App/Core/utilites/localfiles.dart';
import 'package:booking_app/Booking_App/config/themes/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/data/datasources/local/cacheHelper.dart';
import 'package:booking_app/Booking_App/features/data/models/hotel_list.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/blocs/states.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/account/login/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/hotel_details/hotel_room_list.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/map/map_page.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/common_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../Core/utilites/app_constance.dart';
import '../../../../data/models/login_model.dart';
import '../../../widgets/show_toast.dart';
import '../../map/map_screen.dart';
import '../app_layout.dart';
import '../hotel_screens/booking_screen.dart';
import '../hotel_screens/hotel_screen.dart';


class HotelDetails extends StatefulWidget {
  int hotelid;
  final String hotelName;
  final String description;
  final String adresse;
  final dynamic price;
  final String latitude;
  final String longitude;
  final String rate;
  final String imagePath;


  HotelDetails({required this.hotelid,required this.longitude ,required this.latitude,required this.imagePath,required this.hotelName, required this.description, required this.adresse,
    required this.price,required this.rate});

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
  LoginModel? loginModel;
  String? firstHalf;
  String? secondHalf;

  bool flag = true;

  late AnimationController animationController;
  var imageHeight = 0.0;

  late AnimationController _animationController;

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    // bearing: 192.8334901395799,
      target:LatLng(30.0504042,
          31.3590117),
      //tilt: 59.440717697143555,
      zoom:  14.4746);

  static final CameraPosition _kLake = CameraPosition(
    // bearing: 192.8334901395799,
      target:LatLng(30.0504042,
          31.3590117),
      //tilt: 59.440717697143555,
      zoom:  14.4746);
  @override
  void initState() {
    // TODO: implement initState
    if (widget.description.length > 50) {
      firstHalf = widget.description.substring(0, 50);
      secondHalf = widget.description.substring(50, widget.description.length);
    } else {
      firstHalf = widget.description;
      secondHalf = "";
    }
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
  //String descText = widget.description;
  bool descTextShowFlag = false;


  @override
  Widget build(BuildContext context) {

    imageHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<AppBloc,AppStates>(
      listener: (context,state){
        if(state is CreateBookingSuccessState){
          showToastMsg(massage: '${AppBloc.get(context).bookingModel!.status!.title?.en}' ,
              state: ToastState.SUCCESS,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG);
          AppConstance.navigateTo(
              router: AppLayout(), context: context);
        }
      },
      builder: (context,index){
        var cubit=AppBloc.get(context);
        int index=cubit.upcomming.length;
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
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 4, bottom: 8),

                      child: Text(widget.description,
                          maxLines: descTextShowFlag ? 20 : 2,textAlign: TextAlign.start, style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Colors.grey),),
                    ),
                    InkWell(
                      onTap: (){ setState(() {
                        descTextShowFlag = !descTextShowFlag;
                      }); },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24,),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            descTextShowFlag ? Text("Show Less",style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.blue),) :  Text("Show More",style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.blue),)
                          ],
                        ),
                      ),
                    ),

                    getPhotoReviewUi(
                        'Photos', Icons.arrow_forward, () {}),
                    HotelRoomList(),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          padding: EdgeInsetsDirectional.only(start: 14 , end: 14),
                          child: GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition:CameraPosition(
                              // bearing: 192.8334901395799,
                                target:LatLng(double.parse(widget.latitude),double.parse(widget.longitude)
                                    ),
                                //tilt: 59.440717697143555,
                                zoom:  14.4746),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, top: 10),
                          child: FloatingActionButton.extended(
                            backgroundColor: Colors.grey.withOpacity(0.6),
                            onPressed: (){
                             // Navigator.pushNamed(context, MapScreen.routeName);
                              AppConstance.navigateTo(context:context ,router:MapPage(latitude: widget.latitude,longitude: widget.longitude,) );
                            },
                            label: Text('see more'),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(top: 24,bottom: 14),
                      padding: EdgeInsetsDirectional.only(start: 24,end: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20),),
        color: AppColors.blueColor,
                      ),
                      child:MaterialButton(

                        onPressed: (){
                          AppBloc.get(context).createBooking(hotelId: widget.hotelid,userId: cubit.profileModel!.data!.id);
                          print(cubit.profileModel!.data!.id);

                        },
                        child: Text('Book Now',style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                        ),
                      )
                      // ListView.builder(
                      //   itemBuilder: (context,index)=> cubit.upcomming[index].type=='upcomming '?
                      //       MaterialButton(
                      //
                      //     onPressed: (){
                      //       showToastMsg(massage: 'Already booking' ,
                      //           state: ToastState.SUCCESS,
                      //           gravity: ToastGravity.BOTTOM,
                      //           toastLength: Toast.LENGTH_LONG);
                      //       //print(cubit.profileModel!.data!.id);
                      //
                      //     },
                      //     child: Text('Book Now',style: TextStyle(
                      //       color: Colors.white,
                      //       fontFamily: 'Poppins',
                      //     ),
                      //     ),
                      //   ):MaterialButton(
                      //
                      //     onPressed: (){
                      //       AppBloc.get(context).createBooking(hotelId: widget.hotelid,userId: cubit.profileModel!.data!.id);
                      //       print(cubit.profileModel!.data!.id);
                      //
                      //     },
                      //     child: Text('Book Now',style: TextStyle(
                      //       color: Colors.white,
                      //       fontFamily: 'Poppins',
                      //     ),
                      //     ),
                      //   ),
                      // )
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
              backgroundImageUi(widget.imagePath),
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


                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
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
                              child:Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                image,
                                ),
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
                                              color: AppColors.blueColor,
                                              borderRadius:
                                              BorderRadius.circular(32)),
                                          child: MaterialButton(
                                            onPressed: () {

                                              AppBloc.get(context).createBooking(hotelId: widget.hotelid,userId: AppBloc.get(context).profileModel!.data!.id);
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

  getHotelsDetails({bool isInList = false,}) {
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
                    color: isInList ? ThemeAppCubit.get(context)
                        .IsDark? Colors.white
                        : AppColors.black: Colors.white,
                    fontSize: 18),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Icon(
                      Icons.location_on_sharp,
                      color: AppColors.blueColor,
                      size: 13,
                    ),
                    Text(
                      widget.adresse,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: isInList
                              ? ThemeAppCubit.get(context)
                              .IsDark? Colors.white
                              : AppColors.black
                              : Colors.white,
                          fontSize: 11),
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
                    RatingBarIndicator(
                      rating: double.parse(
                          '${widget.rate}') /
                          2,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: AppColors.yellow,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      unratedColor:
                      AppColors.grey.withOpacity(.7),
                      direction: Axis.horizontal,
                    ),
                    Text(
                      '(${ double.parse('${widget.rate}')/2})',
                      style: TextStyle(
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
      String title, IconData iconData, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(

                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                fontSize: 12,
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      // bearing: 192.8334901395799,
        target:LatLng(double.parse(widget.latitude),double.parse(widget.longitude)
        ),
        //tilt: 59.440717697143555,
        zoom:  14.4746)));
  }

}