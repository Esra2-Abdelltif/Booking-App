import 'dart:async';

import 'package:booking_app/Booking_App/features/data/models/hotel_list.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = 'location';

  MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Location location = new Location();

  late PermissionStatus permissionStatus;

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

  double defLat = 30.5365568;

  double defLong = 31.6767038;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLocation();
    updateUserMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
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

  void updateUserMarker() {
    var userMarker = Marker(
        markerId: MarkerId('user_location'),
        position: LatLng(30.0504042,
            31.3590117));
    markers.add(userMarker);
    setState(() {});
  }
}
