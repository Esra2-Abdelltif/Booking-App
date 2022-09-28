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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/common_card.dart';
import 'package:path/path.dart';

class Explore extends StatefulWidget {
   String? adress;
  String ?  facilitiesName;
   String ?  facilitiesID;


   Explore({ this.adress,this.facilitiesName,this.facilitiesID});

  @override
  State<Explore> createState() => _Explore();
}

final searchController = TextEditingController();

class _Explore extends State<Explore> with TickerProviderStateMixin {
  late final Animation<double> animation;
  late final AnimationController animationController;
  late final AnimationController _animationController;
  var hotellist = HotelListData.hotelList;
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
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _animationController =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);

    scrollcontriller
      ..addListener(() {
        if (scrollcontriller.offset <= 0) {
          // we static set the just below half scrolling values
          _animationController.animateTo(0.0);
        } else if (scrollcontriller.offset > 0.0 &&
            scrollcontriller.offset < searchBarHeight) {
          _animationController
              .animateTo((scrollcontriller.offset) / searchBarHeight);
        } else {
          _animationController.animateTo(1.0);
        }
      });
    super.initState();
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
      create: (BuildContext context) => sl<SearchCubit>()
        ..getFacilitiesHotels(id: 1,name: "A/C" )..getHotels(address: "")
        ..hotelsBySearch,
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (BuildContext context, SearchStates state) {},
        builder: (BuildContext context, SearchStates state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
              body: Column(children: [
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: _getAppbar(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30,bottom: 15),
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: ThemeAppCubit.get(context).IsDark
                                ?   Colors.grey.shade900
                            : Colors.grey.shade200,
                            spreadRadius: 2,
                            blurRadius: 1,
                           // offset: Offset(0, 3), // changes position of shadow
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
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
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
                                    router: FilterScreeen(), context: context);
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
                                          color:
                                              ThemeAppCubit.get(context).IsDark
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
                ],
              ),
            ),
            Expanded(
              child: ConditionalBuilder(
                  condition: SearchCubit.get(context).hotels != null,
                  builder: (context) => ListView.separated(
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              AppConstance.navigateTo(
                                context: context,
                                router: HotelDetails(
                                  imagePath:
                                      HotelListData.hotelList[index].imagePath,
                                  hotelid:
                                      SearchCubit.get(context).hotels[index].id,
                                  hotelName: SearchCubit.get(context)
                                      .hotels[index]
                                      .name,
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
                              child: Card(
                                //   shadowColor: Theme.of(context).dividerColor,
                                color: ThemeAppCubit.get(context).IsDark
                                    ? AppColors.darkcontiner
                                    : AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ClipRect(
                                    // borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                  child: Column(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 2,
                                        child: Image.asset(
                                          "${HotelListData.hotelList[index].imagePath}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Container(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 8, left: 16, right: 8),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          SearchCubit.get(
                                                                  context)
                                                              .hotels[index]
                                                              .name,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          "\$${SearchCubit.get(context).hotels[index].price}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.location_pin,
                                                          size: 16,
                                                          color: AppColors
                                                              .defultColor,
                                                        ),
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          SearchCubit.get(
                                                                  context)
                                                              .hotels[index]
                                                              .address,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .darkTextColor,
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          '/per night',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .darkTextColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        RatingBarIndicator(
                                                          rating: double.parse(
                                                                  '${SearchCubit.get(context).hotels[index].rate}') /
                                                              2,
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          itemCount: 5,
                                                          unratedColor:
                                                              AppColors.grey
                                                                  .withOpacity(
                                                                      .7),
                                                          itemSize: 20.0,
                                                          direction:
                                                              Axis.horizontal,
                                                        ),
                                                        Text(
                                                          '(${double.parse('${SearchCubit.get(context).hotels[index].rate}') / 2})',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .darkTextColor,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
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
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 5,
                          ),
                      itemCount: SearchCubit.get(context).hotels.length),
                  fallback: (context) => Center(
                        child: CircularProgressIndicator(
                          color: Colors.grey,
                        ),
                      )),
            ),
            //  AnimatedBuilder(animation: _1animationController,
            //  builder: ((context, child) {return Positioned(child: Container());

            // }
            // ),

            // )
            ///////////AminationBuilder //////////////
          ]
                  //)
                  )
              //],
              // ),
              );
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
                AppConstance.navigateTo(router: HomeScreen(),context:context );
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
          child: Text('Explore'),
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

Widget _getSearchBarUI() {
  return Padding(
    padding: const EdgeInsets.only(right: 24, left: 24, top: 16, bottom: 16),
    child: CommonCard(
      color: AppColors.white,
      radius: 36,
      child: CommonSearchBar(
        textEditingController: searchController,
        iconData: FontAwesomeIcons.search,
        TextFormFieldWidget: TextField(
          controller: searchController,
          maxLines: 1,
          enabled: true,
          onChanged: (String txt) {},
          // cursorColor: Theme.of(context).primaryColor,
          decoration: new InputDecoration(
              contentPadding: EdgeInsets.all(0),
              errorText: null,
              border: InputBorder.none,
              hintText: "London...",
              hintStyle: TextStyle(fontSize: 24)
                  .copyWith(color: Colors.grey, fontSize: 18)),
        ),
        enabled: true,
        text: "London...",
      ),
    ),
  );

  /* return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
      child: Card(
      //   shadowColor: Theme.of(context).dividerColor,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
     // borderRadius: BorderRadius.circular(widget.radius),
      ),
      child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(38)),
          onTap: () {
         //   NavigationServices(context).gotoSearchScreen();
          },
          child: CommonSearchBar(
            iconData: Icons.search,
            enabled: false,
            //text: AppLocalizations(context).of("where_are_you_going"),
          ),
        ),
      ),
    );
*/
}
