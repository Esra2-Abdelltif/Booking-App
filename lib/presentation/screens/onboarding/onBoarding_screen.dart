import 'package:booking_app/presentation/screens/onboarding/model_conrtroller.dart';
import 'package:booking_app/utilites/app_colors.dart';
import 'package:booking_app/utilites/size_config.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardinScreen extends StatefulWidget {
  @override
  State<OnBoardinScreen> createState() => _OnBoardinScreenState();
}

class _OnBoardinScreenState extends State<OnBoardinScreen> {
  var boardController = PageController();

  void Onsubmit() {
    // CacheHelper.saveDate(key:'onBoarding', value: true).then((value) =>
    //     NavigateAndFinsh(router:WelcomeScreen(),context: context)
    // );
  }

  bool isLast = false;
  bool isFirst = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double? width = SizeConfig.screenW;
    double? height = SizeConfig.screenH;
    double? blockH = SizeConfig.blockH;
    double? blockV = SizeConfig.blockV;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: boardController,
                  onPageChanged: (int index) {
                    if (index == contents.length - 1) {
                      setState(() {
                        isLast = true;
                        isFirst = false;
                      });
                    } else if (index == 0) {
                      setState(() {
                        isLast = false;
                        isFirst = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                        isFirst = false;
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
                height: 40,
              ),
              Expanded(
                flex: 1,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SmoothPageIndicator(
                              controller: boardController,
                              count: contents.length,
                              effect: ExpandingDotsEffect(
                                activeDotColor: Colors.blue,
                                dotHeight: 14,
                                dotWidth: 14,
                              ),
                            ),
                          ]),
                      isLast
                          ? Padding(
                              padding: const EdgeInsets.all(30),
                              child: ElevatedButton(
                                onPressed: () {
                                  // //bt3ml save lw tm el tsgel
                                  // CacheHelper.saveDate(key:'onBoarding', value: true).then((value) =>
                                  //     NavigateAndFinsh(router:const WelcomeScreen(),context: context)
                                  // );
                                },
                                child: Text("Start"),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: (width! <= 550)
                                      ? EdgeInsets.symmetric(
                                          horizontal: 80, vertical: 20)
                                      : EdgeInsets.symmetric(
                                          horizontal: width! * 0.2,
                                          vertical: 25),
                                  textStyle: TextStyle(
                                      fontSize: (width <= 550) ? 13 : 17),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      boardController.jumpToPage(2);
                                    },
                                    child: Text(
                                      "SKIP",
                                    ),
                                    style: TextButton.styleFrom(
                                      elevation: 0,
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: (width! <= 550) ? 14 : 17,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      boardController.nextPage(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeIn,
                                      );
                                    },
                                    child: Text("NEXT"),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue,
                                      shape: new RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      elevation: 0,
                                      padding: (width <= 550)
                                          ? EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 20)
                                          : EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 25),
                                      textStyle: TextStyle(
                                          fontSize: (width <= 550) ? 13 : 17),
                                    ),
                                  ),
                                ],
                              ),
                            )
                    ]),
              ),
            ],
          ),
        ));
  }

  Widget BuildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Image(
            image: AssetImage('${model.image}'),
            height: SizeConfig.blockV! * 35,
          )),
          const SizedBox(
            height: 30,
          ),
          Center(
              child: Text(
            '${model.title}',
            textAlign: TextAlign.center,
            style:  TextStyle(
              fontSize: 30,
              color:AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          )),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: Text('${model.discription}',
                  textAlign: TextAlign.center,
                  style:  TextStyle(
                      fontWeight: FontWeight.w300,
                      color: AppColors.fontColorGrey,
                      fontSize: 16))),
          const SizedBox(
            height: 10,
          ),
        ],
      );
}
