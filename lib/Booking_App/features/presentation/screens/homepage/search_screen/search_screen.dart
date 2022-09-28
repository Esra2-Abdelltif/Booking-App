import 'package:booking_app/Booking_App/Core/di/injection.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/Core/utilites/assets_manager.dart';
import 'package:booking_app/Booking_App/Core/utilites/hex_color.dart';
import 'package:booking_app/Booking_App/config/themes/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/data/models/hotel_list.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/hotel_details/hotel_details_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/cubit/state.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/common_card.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/custom_appBar_view.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/custom_search.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<SearchCubit>()..hotelsBySearch,
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (BuildContext context, SearchStates state) {},
        builder: (BuildContext context, SearchStates state) {
          // var list =SearchCubit.get(context).SearchProduct("text");
          return Scaffold(
              body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonAppbarView(
                iconData: Icons.close_rounded,
                onBackClick: () {
                  AppConstance.navigatePop(context: context);
                },
                titleText: AppString.search,
              ),
              Expanded(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 24, left: 24, top: 16, bottom: 16),
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
                                SearchCubit.get(context).searchHotels(hotelName: text);
                              },
                              onSaved: (String? text) {
                                searchController = text as TextEditingController;
                              },
                              onChanged: (String text) {
                                SearchCubit.get(context).searchHotels(hotelName: text);
                              },
                              controller: searchController,
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
                      SizedBox(
                        height: 10,
                      ),
                      if (state is SearchLoadingState)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: LinearProgressIndicator(),
                        ),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ConditionalBuilder(
                              condition:
                                  SearchCubit.get(context).hotelsBySearch != null,
                              builder: (context) => ListView.separated(
                                  itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          AppConstance.navigateTo(
                                              context: context,
                                              router: HotelDetails(
                                                imagePath: HotelListData.hotelList[index].imagePath,
                                                  hotelid: SearchCubit.get(context).hotelsBySearch[index].id,
                                                  hotelName: SearchCubit.get(context).hotelsBySearch[index].name,
                                                adresse:SearchCubit.get(context).hotelsBySearch[index].address ,
                                                description: SearchCubit.get(context).hotelsBySearch[index].description,
                                                price: SearchCubit.get(context).hotelsBySearch[index].price ,
                                                rate: SearchCubit.get(context).hotelsBySearch[index].rate ,
                                              ),
                                          );
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 24,
                                              right: 24,
                                              top: 8,
                                              bottom: 15),
                                          child: Card(
                                            //   shadowColor: Theme.of(context).dividerColor,
                                            color: ThemeAppCubit.get(context)
                                                    .IsDark? AppColors.darkcontiner
                                                : AppColors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                          child: Container(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 8,
                                                                  left: 16,
                                                                  right: 8),
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [Text(
                                                                      SearchCubit.get(
                                                                              context)
                                                                          .hotelsBySearch[
                                                                              index]
                                                                          .name,
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ), Text(
                                                                      "\$${SearchCubit.get(context).hotelsBySearch[index].price}",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                                      Icons
                                                                          .location_pin,
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
                                                                          .hotelsBySearch[
                                                                      index]
                                                                          .address,
                                                                      style: TextStyle(
                                                                        color:
                                                                        AppColors.darkTextColor,),
                                                                    ),

                                                                    Spacer(),

                                                                    Text(
                                                                      '/per night',
                                                                      style: TextStyle(
                                                                          color:
                                                                          AppColors.darkTextColor,),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    RatingBarIndicator(
                                                                      rating:
                                                                          double.parse('${SearchCubit.get(context).hotelsBySearch[index].rate}') /
                                                                              2,
                                                                      itemBuilder:
                                                                          (context, index) =>
                                                                              Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: Colors
                                                                            .amber,
                                                                      ),
                                                                      itemCount:
                                                                          5,
                                                                      unratedColor: AppColors
                                                                          .grey
                                                                          .withOpacity(
                                                                              .7),
                                                                      itemSize:
                                                                          20.0,
                                                                      direction:
                                                                          Axis.horizontal,
                                                                    ),
                                                                    Text(
                                                                      '(${double.parse('${SearchCubit.get(context).hotelsBySearch[index].rate}') / 2})',
                                                                      style: TextStyle(
                                                                          color:    AppColors.darkTextColor,
                                                                          fontSize:
                                                                              12),
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
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 5,
                                      ),
                                  itemCount:
                                      SearchCubit.get(context).hotelsBySearch.length),
                              fallback: (context) => Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.grey,
                                    ),
                                  )),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ));
        },
      ),
    );
  }
}
