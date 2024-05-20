import 'package:expenz/Widgets/custom_btn.dart';
import 'package:expenz/constant/colors.dart';
import 'package:expenz/constant/constant.dart';
import 'package:expenz/data/onbording_data.dart';
import 'package:expenz/screens/onbording/front_page.dart';
import 'package:expenz/screens/onbording/shared_onbording_screen.dart';
import 'package:expenz/screens/user_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({super.key});

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  //page controller;
  final PageController _controllers = PageController();
  bool showDetailsPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView(
                  onPageChanged: (index) {
                    setState(() {
                      showDetailsPage = index == 3;
                    });
                  },
                  controller: _controllers,
                  children: [
                    const FroantPage(),
                    SharedOnbordingScreen(
                      title: OnBordaingData.onbordingDataList[0].title,
                      imgPath: OnBordaingData.onbordingDataList[0].imagePath,
                      description:
                          OnBordaingData.onbordingDataList[0].description,
                    ),
                    SharedOnbordingScreen(
                      title: OnBordaingData.onbordingDataList[1].title,
                      imgPath: OnBordaingData.onbordingDataList[1].imagePath,
                      description:
                          OnBordaingData.onbordingDataList[1].description,
                    ),
                    SharedOnbordingScreen(
                      title: OnBordaingData.onbordingDataList[2].title,
                      imgPath: OnBordaingData.onbordingDataList[2].imagePath,
                      description:
                          OnBordaingData.onbordingDataList[2].description,
                    ),
                  ],
                ),
                Container(
                  alignment: const Alignment(0, 0.75),
                  child: SmoothPageIndicator(
                    controller: _controllers,
                    count: 4,
                    effect: const WormEffect(
                      dotColor: kLightGrey,
                      activeDotColor: kMainColor,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 20,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: !showDetailsPage
                        ? GestureDetector(
                            onTap: () {
                              _controllers.animateToPage(
                                _controllers.page!.toInt() + 1,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: CustomBtn(
                              btnColor: kMainColor,
                              btnName: showDetailsPage ? "Get Started" : "Next",
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              //navigate to user data screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UsaerDataScreen(),
                                ),
                              );
                            },
                            child: CustomBtn(
                              btnColor: kMainColor,
                              btnName: showDetailsPage ? "Get Started" : "Next",
                            ),
                          ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
