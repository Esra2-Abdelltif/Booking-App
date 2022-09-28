import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/helper.dart';
import 'package:booking_app/Booking_App/features/data/models/hotel_list.dart';
import 'package:flutter/material.dart';

class ExploreListView extends StatelessWidget {
  late final Animation<double> animation;
  late final AnimationController animationController;
  late final HotelListData hotelData;

  final bool isShowDate;
  final VoidCallback callback;

  ExploreListView(
      {Key? key,
      required this.callback,
      required this.hotelData,
      required this.animation,
      this.isShowDate: false,
      required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 15),
            child: Card(
              //   shadowColor: Theme.of(context).dividerColor,
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColors.grey.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: ClipRect(
                  // borderRadius: BorderRadius.circular(16),
                  child: Container(
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 2,
                      child: Image.asset(hotelData.imagePath, fit: BoxFit.cover,),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Container(
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 8, left: 16, right: 8),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    hotelData.titleTxt,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(hotelData.subTxt),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Icon(
                                        Icons.maps_ugc,
                                        size: 12,
                                      ),
                                      Text(
                                        "${hotelData.dist.toStringAsFixed(1)}",
                                      ),
                                      Expanded(child: Text('20 Km to city')),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Helper.ratingStar(),

                                  ),
                                ]),
                          ),
                        )),
                      ],
                    )
                  ],
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
