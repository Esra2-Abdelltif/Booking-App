import 'package:booking_app/Booking_App/Core/di/injection.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/config/themes/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/cubit/cubit.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/homepage/search_screen/cubit/state.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/common_card.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/custom_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class fmf extends StatelessWidget {
  const fmf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
//Serach
          Row(
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
                        SearchCubit.get(context).searchByFacilitiesHotels();
                      },
                      onSaved: (String? text) {
                        SearchCubit.get(context).searchController =
                            text as TextEditingController;
                      },
                      onChanged: (String text) {
                        SearchCubit.get(context).searchByFacilitiesHotels();
                      },
                      controller: SearchCubit.get(context).searchController,
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
              InkWell(
                  onTap: () {
                    SearchCubit.get(context).searchByFacilitiesHotels();
                  },
                  child: Icon(
                    Icons.sort,
                    color: ThemeAppCubit.get(context).IsDark
                        ? AppColors.white
                        : AppColors.black,
                  ))
            ],
          ),
          SizedBox(
            height: 20,
          ),

          if (SearchCubit.get(context).facilitiesModel != null)
            Wrap(
              runSpacing: 16.0,
              spacing: 16.0,
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
                            SearchCubit.get(context).selectFacility(value.id);
                          },
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            width: 80.0,
                            height: 80.0,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: SearchCubit.get(context)
                                      .selectedFacilities
                                      .any((element) => element == value.id)
                                  ? AppColors.blueColor
                                  : ThemeAppCubit.get(context).IsDark
                                      ? AppColors.darkcontiner
                                      : AppColors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    value.image,
                                    color: ThemeAppCubit.get(context).IsDark
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
                    )
                    .values
                    .toList(),
              ],
            ),
          const SizedBox(
            height: 16.0,
          ),
          MaterialButton(
            color: Colors.teal,
            onPressed: () {
              SearchCubit.get(context).searchByFacilitiesHotels();
            },
            child: const Text('Search'),
          ),

          const SizedBox(
            height: 16.0,
          ),
          if (SearchCubit.get(context).searchHotelsModel != null)
            Text(SearchCubit.get(context)
                .searchHotelsModel!
                .data!
                .data
                .length
                .toString()),
          if (SearchCubit.get(context).searchHotelsModel != null)
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300]!,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: Stack(
                            children: [
                              Image(
                                image: NetworkImage(
                                    'http://api.mahmoudtaha.com/images/${SearchCubit.get(context).searchHotelsModel!.data!.data[index].images[math.Random().nextInt(SearchCubit.get(context).searchHotelsModel!.data!.data[index].images.length)]}'),
                                width: double.infinity,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
// Container(
//   width: double.infinity,
//   height: 200,
//   color: Colors.black38,
// ),
// Align(
//   alignment: Alignment.bottomLeft,
//   child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Row(
//       children: [
//         Container(
//           width: 40.0,
//           height: 40.0,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: const Icon(
//             Icons.ac_unit,
//             color: Colors.grey,
//           ),
//         ),
//         const SizedBox(
//           width: 8.0,
//         ),
//         Container(
//           width: 40.0,
//           height: 40.0,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: const Icon(
//             Icons.ac_unit,
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      SearchCubit.get(context)
                                          .searchHotelsModel!
                                          .data!
                                          .data[index]
                                          .name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${SearchCubit.get(context).searchHotelsModel!.data!.data[index].price}\$',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.amber,
                                    size: 24,
                                  ),
                                  Text(
                                    SearchCubit.get(context)
                                        .searchHotelsModel!
                                        .data!
                                        .data[index]
                                        .rate,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemCount: SearchCubit.get(context)
                    .searchHotelsModel!
                    .data!
                    .data
                    .length,
              ),
            ),
          if (state is SearchLoadingState) const CupertinoActivityIndicator(),
        ],
      ),
    );
  }
}
