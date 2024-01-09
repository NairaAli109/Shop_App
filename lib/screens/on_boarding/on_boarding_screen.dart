// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shop_app_flutter/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../model/on_boarding_model.dart';
import '../../shared/component/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login/login_screen.dart';




class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      title: "ONLINE CART ",
      body: "Select and memorize your future \npurchases with smart online shopping cart.",
      image: 'assets/images/onboarding1.png',
    ),
    BoardingModel(
      title: "SALES AND GIFTS",
      body: "Holiday sales, birthday gifts,\n various choice and categories.",
      image: 'assets/images/onboarding2.png',
    ),
    BoardingModel(
      title: "CLIENT REVIEWS",
      body: "Honest feedbacks from our clients,\nHappy clients-happy us",
      image: 'assets/images/onboarding3.png',
    ),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
        key: 'onBoarding',
        value: true
    ).then((value) {
      if (value) {
        navigateAndFinish(
            context,
            LoginScreen()
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          image: DecorationImage(
              image: const AssetImage('assets/images/background4.png'),
              // colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.9), BlendMode.dstATop),
              fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              defaultTextButton(
                function: () {
                  submit();
                },
                text: 'SKIP',
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: boardController,
                    onPageChanged: (int index) {
                      if (index == boarding.length - 1) {
                        print("last page");
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        print("not last page");
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    itemBuilder: (context, index) =>
                        Column(
                          children: [
                            Expanded(
                              child: Image(
                                image: AssetImage(boarding[index].image),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              boarding[index].title,
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: defaultColor
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 50,end: 50,),
                              child: Text(
                                boarding[index].body,
                                style:  const TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                    itemCount: boarding.length,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SmoothPageIndicator(
                      controller: boardController,
                      count: boarding.length,
                      effect: const ExpandingDotsEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 5,
                        expansionFactor: 4,
                      ),
                    ),
                    const Spacer(),
                    FloatingActionButton(
                      onPressed: () {
                        if (isLast) {
                          submit();
                        } else {
                          boardController.nextPage(
                              duration: const Duration(milliseconds: 750),
                              curve: Curves.fastLinearToSlowEaseIn);
                        }
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}
