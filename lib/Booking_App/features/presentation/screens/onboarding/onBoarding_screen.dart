
import 'package:booking_app/Booking_App/Core/utilites/app_colors.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_constance.dart';
import 'package:booking_app/Booking_App/Core/utilites/app_strings.dart';
import 'package:booking_app/Booking_App/Core/utilites/hex_color.dart';
import 'package:booking_app/Booking_App/Core/utilites/size_config.dart';
import 'package:booking_app/Booking_App/features/data/datasources/local/cacheHelper.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/account/login/login_screen_.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/account/register/register_screen.dart';
import 'package:booking_app/Booking_App/features/presentation/screens/onboarding/model_conrtroller.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/CustomRowText.dart';
import 'package:booking_app/Booking_App/features/presentation/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardinScreen extends StatefulWidget {
  @override
  State<OnBoardinScreen> createState() => _OnBoardinScreenState();
}

class _OnBoardinScreenState extends State<OnBoardinScreen> {
  var boardController = PageController();
  bool isLast = true;
  bool isFirst = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            isLast
                ? Row(
                    children: [
                      Spacer(),
                      CustomButton(
                        text: AppString.skip,
                        width: 80,
                        borderRadius: 50,
                        color: HexColor("#faf2e7"),
                        borderColor: HexColor("#faf2e7"),
                        Fontcolor: Colors.black,
                        onTap: () {
                          boardController.jumpToPage(2);
                        },
                      )
                    ],
                  )
                : SizedBox(
                    height: 40,
                  ),
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == contents.length - 1) {
                    setState(() {
                      isLast = false;
                    });
                  } else {
                    setState(() {
                      isLast = true;
                    });
                  }
                },
                // physics: BouncingScrollPhysics(), //?????????? ?????????? ?????? ?????????? ???? ?????? ?????? ???????? ??????????????
                itemBuilder: ((context, index) =>
                    BuildBoardingItem(contents[index])),
                itemCount: contents.length,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: contents.length,
                    effect: SlideEffect(
                      spacing: 5.0,
                      radius: 8.0,
                      dotWidth: 20.0,
                      dotHeight: 7.0,
                      dotColor: HexColor('#dadada'),
                      activeDotColor: AppColors.blueColor,
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomButton(
                    text: AppString.getStarted,
                    borderRadius: 15,
                    borderColor: AppColors.blueColor,
                    onTap: () {
                      CacheHelper.saveDate(key:'onBoarding', value: true).then((value) =>
                          navigateAndFinsh(context: context,router: LoginScreen())
                      );

                    },
                  ),
                ),
                CustomRowText(
                  textcolor: AppColors.blueColor,
                      Text1: AppString.dontHaveAnAccount,
                    Text2: AppString.signUp,
                    onPressed: () {
                      CacheHelper.saveDate(key:'onBoarding', value: true).then((value) =>
                          navigateAndFinsh(context: context,router: RegisterScreen())
                      );

                    }),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildBoardingItem(BoardingModel model) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Image(
              image: AssetImage('${model.image}'),
            )),
            const SizedBox(
              height: 30,
            ),
            Center(
                child: Text(
              '${model.title}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            )),
            const SizedBox(
              height: 15,
            ),
            Center(
                child: Text('${model.discription}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8D8E98),
                        fontSize: 16))),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
}
