//HotelHomeScreen
import 'package:booking_app/Booking_App/Core/di/injection.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/config/themes/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/data/models/hotel_list.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/filiter_screen/filter_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/home_screen/home_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/hotel_details/hotel_details_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/cubit/state.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/search_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/map/map_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/custom_search.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/explorelistview.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/common_card.dart';
import 'package:path/path.dart';
import 'dart:math' as math;

class Explore extends StatefulWidget {
  String? adress;
  String? facilitiesName;
  int? facilitiesID;

  Explore({this.adress, this.facilitiesName, this.facilitiesID});

  @override
  State<Explore> createState() => _Explore();
}

final searchController = TextEditingController();

class _Explore extends State<Explore> with TickerProviderStateMixin {
  late final Animation<double> animation;
  late final AnimationController animationController;
  late final AnimationController _animationController;
  var hotellist = HotelListData.hotelList;
  ScrollController scrollController = ScrollController();
  ScrollController scrollcontriller = new ScrollController();
  int room = 1;
  int add = 2;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 5));
  bool isShowMap = false;
  final searchBarHeight = 158.0;
  final filterBarHeight = 52.0;

  @override
  void initState() {
    super.initState();

    // SearchCubit.get(context).getHotels(
    //   isForce: true,
    // );
    //
    // scrollController.addListener(() {
    //   if (scrollController.position.extentAfter == 0 &&
    //       !SearchCubit.get(context).isEnd &&
    //       SearchCubit.get(context).lastPage >=
    //           SearchCubit.get(context).currentPage) {
    //     debugPrint('maxScrollExtent');
    //     SearchCubit.get(context).toggleIsEnd();
    //     SearchCubit.get(context).getHotels();
    //   }
    // });
  }

  Future<bool> getdata() async {
    await Future.delayed(Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
          return Scaffold(
              appBar: AppBar(
                title: const Text('Explore'),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MapScreen.routeName);
                    },
                    icon: const Icon(
                      Icons.map_outlined,
                    ),
                  ),
                ],
              ),
              body: CustomScrollView(

                  controller: scrollController, slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: false,
                  delegate: SliverAppBarDelegate(
                    minHeight: 55.0,
                    maxHeight: 55.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 15),
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: ThemeAppCubit.get(context).IsDark
                                  ? Colors.grey.shade900
                                  : Colors.grey.shade200,
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(25),
                          color: ThemeAppCubit.get(context).IsDark
                              ? AppColors.darkcontiner
                              : AppColors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              AppConstance.navigateTo(
                                  router: SearchScreen(), context: context);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: AppColors.defultColor,
                                ),
                                Text(AppString.where_are_you_goning,
                                    style: TextStyle(fontSize: 24).copyWith(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          ),
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
                              child: Text("${cubit.hotels.length.toInt()}")),
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left: 1),
                                child: Text('Hotel Found')),
                          ),
                          Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                onTap: () {
                                  AppConstance.navigateTo(
                                      router: FilterScreeen(),
                                      context: context);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 1),
                                  child: Row(
                                    children: [
                                      Text('Filter'),
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Icon(
                                            Icons.sort,
                                            color: ThemeAppCubit.get(context)
                                                    .IsDark
                                                ? AppColors.white
                                                : AppColors.black,
                                          )),
                                    ],
                                  ),
                                ),
                              )),
                        ]),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    if (SearchCubit.get(context).hotels.isNotEmpty)
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  AppConstance.navigateTo(
                                    context: context,
                                    router: HotelDetails(
                                      imagePath:
                                          'http://api.mahmoudtaha.com/images/${SearchCubit.get(context).hotels[index].images[math.Random().nextInt(SearchCubit.get(context).hotels[index].images.length)]}',
                                      hotelid: SearchCubit.get(context)
                                          .hotels[index]
                                          .id,
                                      hotelName: SearchCubit.get(context)
                                          .hotels[index]
                                          .name,
                                      longitude: SearchCubit.get(context).hotels[index].longitude,
                                      latitude: SearchCubit.get(context)
                                          .hotels[index].latitude,
                                      adresse: SearchCubit.get(context)
                                          .hotels[index]
                                          .address,
                                      description: SearchCubit.get(context)
                                          .hotels[index]
                                          .description,
                                      price: SearchCubit.get(context)
                                          .hotels[index]
                                          .price,
                                      rate: SearchCubit.get(context)
                                          .hotels[index]
                                          .rate,
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 24, right: 24, top: 8, bottom: 15),
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
                                                'http://api.mahmoudtaha.com/images/${
                                                    SearchCubit.get(context).hotels[index].images[math.Random().nextInt(SearchCubit.get(context).hotels[index].images.length)]}'),
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
                                                          SearchCubit.get(
                                                                  context)
                                                              .hotels[
                                                                  index]
                                                              .name,
                                                          overflow:
                                                              TextOverflow
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
                                                                    .hotels[
                                                                        index]
                                                                    .address,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .grey,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        15),
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
                                                                              '${SearchCubit.get(context).hotels[index].rate}') /
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
                                                                  '(${double.parse('${SearchCubit.get(context).hotels[index].rate}') / 2})',
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
                                                                "\$${SearchCubit.get(context).hotels[index].price}",
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
                          itemCount: SearchCubit.get(context).hotels.length),
                    if (SearchCubit.get(context).hotels.isEmpty)
                      const CupertinoActivityIndicator(),

                  ]),
                ),
              ]));
        },
      ),
    );
  }
}

Widget _getAppbar(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: 8, left: 8, right: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: AppBar().preferredSize.height + 40,
          height: AppBar().preferredSize.height,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
              onTap: () {
                AppConstance.navigatePop(context: context);
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back,
                    color: ThemeAppCubit.get(context).IsDark
                        ? AppColors.white
                        : AppColors.black),
              ),
            ),
          ),
        ),
        Expanded(
            child: Center(
          child: Text('Explore', style: TextStyle(fontWeight: FontWeight.bold)),
        )),
        Container(
          width: AppBar().preferredSize.height + 40,
          height: AppBar().preferredSize.height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  onTap: () {
                    Navigator.pushNamed(context, MapScreen.routeName);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.map_outlined,
                        color: ThemeAppCubit.get(context).IsDark
                            ? AppColors.white
                            : AppColors.black),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
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
