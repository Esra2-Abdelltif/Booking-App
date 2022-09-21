import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/common_card.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/custom_appBar_view.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/custom_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();
   SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              titleText: "Search",
            ),
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children:  [
                      Padding(
                        padding: const EdgeInsets.only(right: 24,left: 24,top: 16,bottom: 16),
                        child: CommonCard(
                          color: AppColors.white,
                          radius: 36,
                          child: CommonSearchBar(
                            textEditingController: searchController,
                            iconData: FontAwesomeIcons.search,
                            enabled: true,
                            text: "Where are you goning",

                          ),
                        ),
                      ),

                    ],

                  ),
                )),
          ],
        ));
  }
}
