import 'dart:async';
import 'package:booking_app/Booking_App/Core/di/injection.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/config/themes/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:math' as math;


class MapScreen extends StatefulWidget {
  static const String routeName = 'location';

  MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Location location = new Location();

  late PermissionStatus permissionStatus;
  Set<Marker>_markers = Set<Marker>();
  bool is_services_enable = false;

  LocationData? locationData = null;
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex =CameraPosition(
    // bearing: 192.8334901395799,
      target:LatLng(30.0504042,
          31.3590117),
      //tilt: 59.440717697143555,
      zoom:  14.4746);

  static final CameraPosition _kLake = CameraPosition(
    // bearing: 192.8334901395799,
      target: LatLng(30.0504042,
          31.3590117),
      //tilt: 59.440717697143555,
      zoom:  14.4746);

  Set<Marker> markers = {};
  int markerIdCounter = 1;

  double defLat = 30.5365568;

  double defLong = 31.6767038;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 1, viewportFraction: 0.85);
    super.initState();
    getUserLocation();
    updateUserMarker();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<SearchCubit>()..getHotels()..hotelsBySearch,
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (BuildContext context, SearchStates state) {
          if (state is SearchErrorState ) {}
        },
        builder: (BuildContext context, SearchStates state) {
          var cubit = SearchCubit.get(context);
          return  Scaffold(
            body: Column(
              children: [
                Stack(

                  children: [

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        markers: _markers,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },

                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      child: SizedBox(
                        height: 200.0,
                        width: MediaQuery.of(context).size.width,
                        child: PageView.builder(
                          controller: _pageController,
                          itemBuilder:(context, index) {
                            return InkWell(
                              onTap: (){
                                gotoSearchedPlace(double.tryParse(SearchCubit.get(context).hotels[index].latitude)!.toDouble()
                                    ,double.tryParse(SearchCubit.get(context).hotels[index].longitude)!.toDouble());
                                _markers = {};

                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 8.0, left: 8.0, bottom: 8),
                                child: Card(
                                  elevation: 2,
                                  shadowColor:ThemeAppCubit.get(context).IsDark ?   Colors.grey.shade900 : Colors.grey.shade200,
                                  color: ThemeAppCubit.get(context).IsDark? AppColors.darkcontiner : AppColors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(16),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height*0.16,
                                    color: ThemeAppCubit.get(context).IsDark ? AppColors.darkcontiner : AppColors.white,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 8.0, top: 8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width:230,
                                                    child: Text(
                                                      cubit.hotels[index].name,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: 'Poppins',
                                                          color: ThemeAppCubit.get(context).IsDark
                                                              ? AppColors.white
                                                              : AppColors.black,
                                                          fontSize: 17),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .location_pin,
                                                    size: 16,
                                                    color: AppColors
                                                        .defultColor,
                                                  ),
                                                  SizedBox(width: 8,),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width:200,
                                                        child: Text(
                                                          cubit.hotels[index].address,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                              color: AppColors.grey,
                                                              fontFamily: 'Poppins',
                                                              fontSize:15 ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),




                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [

                                                  SizedBox(width: 170,),
                                                  Text(
                                                    '\$${cubit.hotels[index].price}',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 17
                                                    ),
                                                  ),




                                                ],
                                              ),

                                              Row(
                                                children: [
                                                  RatingBarIndicator(
                                                    rating: double.parse(
                                                        '${cubit.hotels[index].rate}') /
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
                                                    '(${double.parse('${cubit.hotels[index].rate}') / 2})',
                                                    style: TextStyle(
                                                        color:  AppColors.grey,
                                                        fontSize: 10,
                                                        fontFamily: 'Poppins'
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 30,
                                                  ),

                                                  Text(
                                                    '/per night',
                                                    style: TextStyle(
                                                        color:  AppColors.grey,
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins'
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } ,
                          itemCount: SearchCubit.get(context).hotels.length,


                        ),
                      ),
                    ),


                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }



  //permission
  Future<bool> permissionIsGranted() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  //services
  Future<bool> isServicesEnabled() async {
    is_services_enable = await location.serviceEnabled();
    if (!is_services_enable) {
      is_services_enable = await location.requestService();
    }
    return is_services_enable;
  }

  void getUserLocation() async {
    var permissionGranted = await permissionIsGranted();
    var servicesEnabled = await isServicesEnabled();
    if (permissionGranted == false) return; //user denied permission
    if (servicesEnabled == false) return; //user didn't't allow to open gps
    if (permissionGranted && servicesEnabled) {
      locationData = await location.getLocation();
      print('${locationData?.latitude ?? 0} ,${locationData?.longitude ?? 0}');
      location.onLocationChanged.listen((newestLocation) {
        locationData = newestLocation;
        print(
            '${locationData?.latitude ?? 0} ,${locationData?.longitude ?? 0}');
      });
    }
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  void updateUserMarker({ String lat="30.0504042", String log="31.3590117"}) {
    var userMarker = Marker(
        markerId: MarkerId('user_location'),
        position: LatLng(double.parse(lat),
            double.parse(log)));
    markers.add(userMarker);
    setState(() {});
  }


  Future<void> gotoSearchedPlace(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12)));

    _setMarker(LatLng(lat, lng));
  }
  void _setMarker(point) {
    var counter = markerIdCounter++;

    final Marker marker = Marker(
        markerId: MarkerId('marker_$counter'),
        position: point,
        infoWindow: InfoWindow(
          title: 'hotel',
        ),
        onTap: () {},
        icon: BitmapDescriptor.defaultMarker);

    setState(() {
      _markers.add(marker);
    });
  }
}

