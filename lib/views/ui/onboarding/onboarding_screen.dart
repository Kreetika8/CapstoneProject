import 'package:classico/constants/app_constants.dart';
import 'package:classico/controllers/exports.dart';
import 'package:classico/views/common/app_style.dart';
import 'package:classico/views/common/reusable_text.dart';
import 'package:classico/views/ui/onboarding/widgets/page_one.dart';
import 'package:classico/views/ui/onboarding/widgets/page_three.dart';
import 'package:classico/views/ui/onboarding/widgets/page_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnBoardNotifier>(
        builder: (context, onBoardNotifier, child) {
          return Stack(
            children: [
              PageView(
                physics: onBoardNotifier.isLastPage
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                controller:
                    pageController, // Corrected to use pageController instance
                onPageChanged: (page) {
                  onBoardNotifier.isLastPage = page == 2;
                },
                children: const [
                  PageOne(),
                  PageTwo(),
                  PageThree(),
                ],
              ),
              Positioned(
                  bottom: height * 0.10,
                  left: 0,
                  right: 0,
                  child: onBoardNotifier.isLastPage
                      ? const SizedBox.shrink()
                      : Center(
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: 3,
                            effect: WormEffect(
                                dotHeight: 12,
                                dotWidth: 12,
                                spacing: 10,
                                dotColor:
                                    Color(kDarkGrey.value).withOpacity(0.5),
                                activeDotColor: Color(kDark.value)),
                          ),
                        )),
              Positioned(
                  child: onBoardNotifier.isLastPage
                      ? SizedBox.shrink()
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 38.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    pageController.jumpToPage(2);
                                  },
                                  child: ReusableText(
                                    text: "Skip",
                                    style: appstyle(16, Color(kLightBlue.value),
                                        FontWeight.w500),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease);
                                  },
                                  child: ReusableText(
                                    text: "Next",
                                    style: appstyle(16, Color(kLightBlue.value),
                                        FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
            ],
          );
        },
      ),
    );
  }
}
