import 'package:booking_app/presentation/screens/onboarding/model_conrtroller.dart';
import 'package:booking_app/presentation/widgets/CustomRowText.dart';
import 'package:booking_app/presentation/widgets/customButton.dart';
import 'package:booking_app/utilites/app_colors.dart';
import 'package:booking_app/utilites/hex_color.dart';
import 'package:booking_app/utilites/size_config.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardinScreen extends StatefulWidget {
  @override
  State<OnBoardinScreen> createState() => _OnBoardinScreenState();
}

class _OnBoardinScreenState extends State<OnBoardinScreen> {
  var boardController = PageController();
  bool isLast = true;

  void Onsubmit() {
    // CacheHelper.saveDate(key:'onBoarding', value: true).then((value) =>
    //     NavigateAndFinsh(router:WelcomeScreen(),context: context)
    // );
  }

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
                        text: 'Skip',
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
                // physics: BouncingScrollPhysics(), //بتشيل اللون الي بيظهر في جنب لما بوصل للنهايه
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
                    text: 'Get Started',
                    borderRadius: 15,
                    borderColor: AppColors.blueColor,
                    onTap: () {
                      // NavigateTo(context: context,router: ());
                    },
                  ),
                ),
                CustomRowText(
                  textcolor: AppColors.blueColor,
                    Text1: 'Don\'t have an account ?',
                    Text2: 'Sign Up',
                    onPressed: () {
                      //NavigateTo(router: SignUpScreen(), context: context);
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
