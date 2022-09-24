import 'package:booking_app/Booking_App/Core/di/injection.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/Core/utilites/assets_manager.dart';
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
      create: (BuildContext context) => sl<SearchCubit>()..hotels,
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
                          color: AppColors.white,
                          radius: 36,
                          child: CommonSearchBar(
                            IsSearch: true,
                            //textEditingController: searchController,
                            iconData: FontAwesomeIcons.search,
                            TextFormFieldWidget: TextFormField(
                              style: Theme.of(context).textTheme.bodyText1,
                              onFieldSubmitted: (String text) {
                                SearchCubit.get(context)
                                    .searchHotels(hotelName: text);
                              },
                              onSaved: (String? text) {
                                searchController =
                                    text as TextEditingController;
                              },
                              onChanged: (String text) {
                                SearchCubit.get(context)
                                    .searchHotels(hotelName: text);
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
                                  SearchCubit.get(context).hotels != null,
                              builder: (context) => ListView.separated(
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: (){
                                      AppConstance.navigateTo(context: context,router: HotelDetails());

                                    },
                                    child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 24,
                                              right: 24,
                                              top: 8,
                                              bottom: 15),
                                          child: Card(
                                            //   shadowColor: Theme.of(context).dividerColor,
                                            color: AppColors.white,
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
                                                      "assests/images/slider_1.png",
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
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 8,
                                                                  left: 16,
                                                                  right: 8),
                                                          child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      SearchCubit.get(context).hotels[index].name,style: TextStyle(fontWeight: FontWeight.bold),
                                                                    ),
                                                                    Text(
                                                                     "\$${ SearchCubit.get(context).hotels[index].price}",style: TextStyle(fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(height: 10,),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(SearchCubit.get(context).hotels[index].adresse,style: TextStyle(color: Colors.black38),),
                                                                    SizedBox(
                                                                      width: 4,
                                                                    ),
                                                                    Icon(
                                                                      Icons.location_pin
                                                                          ,
                                                                      size: 16,
                                                                      color: AppColors.defultColor,
                                                                    ),

                                                                    Expanded(
                                                                        child: Text(
                                                                            '20 Km to city',style: TextStyle(color: Colors.black38),)),
                                                                    Text(
                                                                      '/per night',style: TextStyle(color: Colors.black38),)
                                                                  ],
                                                                ),
                                                                SizedBox(height: 10,),
                                                                Row(children: [
                                                                  RatingBarIndicator(
                                                                    rating:  double.parse('${SearchCubit.get(context).hotels[index].rate}'),
                                                                    itemBuilder: (context, index) => Icon(
                                                                      Icons.star,
                                                                      color: Colors.amber,
                                                                    ),
                                                                    itemCount: 10,
                                                                    itemSize: 20.0,
                                                                    direction: Axis.horizontal,
                                                                  ),
                                                                  Text('(${SearchCubit.get(context).hotels[index].rate})',style: TextStyle(color: Colors.black38,fontSize: 12),),
                                                                ],)
                                                                ,
                                                                SizedBox(height: 20,),
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
                                      SearchCubit.get(context).hotels.length),
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
