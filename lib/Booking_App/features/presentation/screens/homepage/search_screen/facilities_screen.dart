import 'package:booking_app/Booking_App/Core/di/injection.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/config/themes/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/hotel_details/hotel_details_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/cubit/state.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/common_card.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/custom_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class facilitiesScreen extends StatefulWidget {
  const facilitiesScreen({Key? key}) : super(key: key);

  @override
  State<facilitiesScreen> createState() => _facilitiesScreenState();
}

class _facilitiesScreenState extends State<facilitiesScreen> {
  ScrollController scrollController = ScrollController();

  bool isSelect = true;

  @override
  void initState() {
    super.initState();

    SearchCubit.get(context).getFacilities();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (BuildContext context, SearchStates state) {},
      builder: (BuildContext context, SearchStates state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Filter'),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16,top: 9),
                child: InkWell(
                    onTap: () {
                      SearchCubit.get(context).searchByFacilitiesHotels();
                    },
                    child: Icon(
                      Icons.sort,
                      color: ThemeAppCubit.get(context).IsDark
                          ? AppColors.white
                          : AppColors.black,
                    )),
              )
            ],
          ),
          body: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: false,
                delegate: SliverAppBarDelegate(
                  minHeight: 55.0,
                  maxHeight: 55.0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0,left: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: CommonCard(
                            color: ThemeAppCubit.get(context).IsDark
                                ? AppColors.darkcontiner
                                : AppColors.white,
                            radius: 36,
                            child: CommonSearchBar(
                              IsSearch: true,
//textEditingController: searchController,
                              iconData: FontAwesomeIcons.search,
                              TextFormFieldWidget: TextFormField(
                                style: Theme.of(context).textTheme.bodyText1,
                                onFieldSubmitted: (String text) {
                                  SearchCubit.get(context)
                                      .searchByFacilitiesHotels();
                                },
                                onSaved: (String? text) {
                                  SearchCubit.get(context).searchController =
                                      text as TextEditingController;
                                },
                                onChanged: (String text) {
                                  SearchCubit.get(context)
                                      .searchByFacilitiesHotels();
                                },
                                controller:
                                    SearchCubit.get(context).searchController,
                                keyboardType: TextInputType.text,
                                cursorColor: Theme.of(context).primaryColor,
                                maxLines: 1,
                                enabled: true,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                    errorText: null,
                                    border: InputBorder.none,
                                    hintText: AppString.where_are_you_goning,
                                    hintStyle: TextStyle(fontSize: 24).copyWith(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 10),
                  ],
                ),
              ),

              if (SearchCubit.get(context).facilitiesModel != null)
                SliverPersistentHeader(
                  pinned: false,
                  delegate: SliverAppBarDelegate(
                    minHeight: 90.0,
                    maxHeight: 90.0,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          // runSpacing: 16.0,
                          // spacing: 16.0,
                         // direction: Axis.vertical,
                          children: [
                            ...SearchCubit.get(context)
                                .facilitiesModel!
                                .data!
                                .asMap()
                                .map(
                                  (key, value) => MapEntry(
                                key,
                                    InkWell(
                                      onTap: () {
                                        SearchCubit.get(context)
                                            .selectFacility(value.id);
                                        SearchCubit.get(context)
                                            .searchByFacilitiesHotels();
                                      },
                                      borderRadius: BorderRadius.circular(25.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 88.0,
                                          height: 88.0,
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: SearchCubit.get(context)
                                                .selectedFacilities
                                                .any((element) =>
                                            element == value.id)
                                                ? AppColors.blueColor
                                                : ThemeAppCubit.get(context).IsDark
                                                ? AppColors.darkcontiner
                                                : AppColors.white,
                                            borderRadius: BorderRadius.circular(18.0),
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Image.network(
                                                  value.image,
                                                  color: ThemeAppCubit.get(context)
                                                      .IsDark
                                                      ? AppColors.white
                                                      : AppColors.darkcontiner,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8.0,
                                              ),
                                              Text(
                                                value.name,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              ),
                            )
                                .values
                                .toList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              if (SearchCubit.get(context).searchHotelsModel != null)
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: SliverAppBarDelegate(
                    minHeight: 40.0,
                    maxHeight: 40.0,
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Padding(
                        padding:
                        EdgeInsets.only(left: 16, right: 16, bottom: 4),
                        child: Row(children: [
                          Padding(
                              padding: EdgeInsets.all(9),
                              child: Text(SearchCubit.get(context)
                                  .searchHotelsModel!
                                  .data!
                                  .data
                                  .length
                                  .toString())),
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left: 1),
                                child: Text('Hotel Found')),
                          ),
                          Material(
                              color: Colors.transparent,
                              child:  Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: InkWell(
                                    onTap: () {
                                      //  SearchCubit.get(context).searchByFacilitiesHotels();
                                      SearchCubit.get(context).selectedFacilities.clear();
                                      SearchCubit.get(context).searchByFacilitiesHotels();
                                    },
                                    child: Text(
                                      "clear all",
                                      style: TextStyle(color: AppColors.blueColor),
                                    )),
                              ),),
                        ]),
                      ),
                    ),
                  ),
                ),
              if (SearchCubit.get(context).searchHotelsModel != null)
                SliverList(
                  delegate: SliverChildListDelegate([
                    if (SearchCubit.get(context)
                        .searchHotelsModel!
                        .data!
                        .data
                        .isNotEmpty)
                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    AppConstance.navigateTo(
                                      context: context,
                                      router: HotelDetails(
                                        imagePath:
                                            'http://api.mahmoudtaha.com/images/${SearchCubit.get(context).searchHotelsModel!.data!.data[index].images[0]}',
                                        hotelid: SearchCubit.get(context)
                                            .searchHotelsModel!
                                            .data!
                                            .data[index]
                                            .id,
                                        hotelName: SearchCubit.get(context)
                                            .searchHotelsModel!
                                            .data!
                                            .data[index]
                                            .name,
                                        longitude: SearchCubit.get(context)
                                            .searchHotelsModel!
                                            .data!
                                            .data[index]
                                            .longitude,
                                        latitude: SearchCubit.get(context)
                                            .searchHotelsModel!
                                            .data!
                                            .data[index]
                                            .latitude,
                                        adresse: SearchCubit.get(context)
                                            .searchHotelsModel!
                                            .data!
                                            .data[index]
                                            .address,
                                        description: SearchCubit.get(context)
                                            .searchHotelsModel!
                                            .data!
                                            .data[index]
                                            .description,
                                        price: SearchCubit.get(context)
                                            .searchHotelsModel!
                                            .data!
                                            .data[index]
                                            .price,
                                        rate: SearchCubit.get(context)
                                            .searchHotelsModel!
                                            .data!
                                            .data[index]
                                            .rate,
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 24,
                                        right: 24,
                                        top: 8,
                                        bottom: 15),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: ThemeAppCubit.get(context).IsDark
                                            ? AppColors.darkcontiner
                                            : AppColors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Column(
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 2,
                                            child: Image(
                                              image: NetworkImage(
                                                  'http://api.mahmoudtaha.com/images/${SearchCubit.get(context).searchHotelsModel!.data!.data[index].images[0]}'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        SearchCubit.get(context)
                                                            .searchHotelsModel!
                                                            .data!
                                                            .data[index]
                                                            .name,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.location_pin,
                                                            size: 16,
                                                            color: AppColors
                                                                .defultColor,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              SearchCubit.get(
                                                                      context)
                                                                  .searchHotelsModel!
                                                                  .data!
                                                                  .data[index]
                                                                  .address,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color:
                                                                      AppColors
                                                                          .grey,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize: 15),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              RatingBarIndicator(
                                                                rating: double
                                                                        .parse(
                                                                            '${SearchCubit.get(context).searchHotelsModel!.data!.data[index].rate}') /
                                                                    2,
                                                                itemBuilder:
                                                                    (context,
                                                                            index) =>
                                                                        Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .amber,
                                                                ),
                                                                itemCount: 5,
                                                                unratedColor:
                                                                    AppColors
                                                                        .grey
                                                                        .withOpacity(
                                                                            .7),
                                                                itemSize: 20.0,
                                                                direction: Axis
                                                                    .horizontal,
                                                              ),
                                                              Text(
                                                                '(${double.parse('${SearchCubit.get(context).searchHotelsModel!.data!.data[index].rate}') / 2})',
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .darkTextColor,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 5),
                                                            child: Text(
                                                              "\$${SearchCubit.get(context).searchHotelsModel!.data!.data[index].price}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                    ]),
                                              )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 5,
                                ),
                            itemCount: SearchCubit.get(context)
                                .searchHotelsModel!
                                .data!
                                .data
                                .length),
                      ),
                    if (SearchCubit.get(context)
                        .searchHotelsModel!
                        .data!
                        .data
                        .isEmpty)
                      const CupertinoActivityIndicator(),
                  ]),
                ),
            ],
          ),
        );
      },
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / maxExtent;

    // debugPrint('progress => $progress');

    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      // height: progress,
      child: child,
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
