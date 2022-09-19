import 'package:flutter/material.dart';
import 'package:shop_app/modules/registration/login_screen.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/local/sharedpreference.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/onboarding_model.dart';
import '../../shared/widgets.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<OnBoarding_model> onboard = [
    OnBoarding_model(
        body: "try our app for easy shopping",
        title: "Easy Shopping",
        image: "assets/images/p1.png"),
    OnBoarding_model(
        body: "find favorite items that you want to buy",
        title:"Find Favorite Items" ,
        image: "assets/images/p2.png"),
    OnBoarding_model(
        body: "discover our big sale",
        title:"70% DISCOUNT" ,
        image: "assets/images/p3.png"),
  ];
  var controler = PageController();
  bool islast = false;
  void submit(context)async{
     await  CachHelper.setBoolData(key: "onboarding", value: true);
       Navigate_to_with_replacement(context: context, screen: LoginScreen());

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit(context);
            },
            child: Text(
              "Skip",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controler,
              onPageChanged: (index) {
                setState(() {
                  if (index == onboard.length - 1) {
                    islast = true;
                  } else {
                    islast = false;
                  }
                });
              },
              itemBuilder: (context, index) => Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Image.asset(
                      onboard[index].image,
                      height: 500,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text(
                            onboard[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primary_color,
                                fontSize: 25),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            onboard[index].body,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primary_color,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              itemCount: onboard.length,
              physics: const BouncingScrollPhysics(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              children: [
                SmoothPageIndicator(
                    controller: controler,
                    effect: const ExpandingDotsEffect(),
                    count: onboard.length),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      submit(context);
                    } else {
                      controler.nextPage(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
