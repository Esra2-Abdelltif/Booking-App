import 'package:booking_app/Booking_App/Core/utilites/localfiles.dart';
import 'package:flutter/material.dart';

class HotelRoomList extends StatefulWidget {
  const HotelRoomList({Key? key}) : super(key: key);

  @override
  State<HotelRoomList> createState() => _HotelRoomListState();
}

class _HotelRoomListState extends State<HotelRoomList> {
  List<String> photoList = [
    //'assests/images/hotel_room_1.jpg',
    Localfiles.hotel_room_1,
    Localfiles.hotel_room_2,
    Localfiles.hotel_room_3,
    Localfiles.hotel_room_4,
    Localfiles.hotel_room_5,
    Localfiles.hotel_room_6,
    Localfiles.hotel_room_7,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 0, bottom: 8, right: 16, left: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    photoList[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: photoList.length,
      ),
    );
  }
}
