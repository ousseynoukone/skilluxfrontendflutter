import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/extensions/context_extension.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';
import 'package:skilluxfrontendflutter/presentations/onBoard/intro_screens/intro_page_1.dart';
import 'package:skilluxfrontendflutter/presentations/onBoard/intro_screens/intro_page_2.dart';
import 'package:skilluxfrontendflutter/presentations/onBoard/intro_screens/intro_page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  final numberOfIntroPage = 3;
  bool isOnLastPage = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) {
              // Check if we are on the last page
              setState(() {
                isOnLastPage = (value == numberOfIntroPage - 1);
              });
            },
            children: const [IntroPage1(), IntroPage2(), IntroPage3()],
          ),
          Container(
              alignment: const Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Skip button
                  GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(numberOfIntroPage - 1);
                    },
                    child: Text(context.localizations.skip,
                        style: textTheme.labelMedium
                            ?.copyWith(color: ColorsTheme.white)),
                  ),

                  // dot indicator
                  SmoothPageIndicator(
                      effect: const ExpandingDotsEffect(
                        activeDotColor:
                            ColorsTheme.white, // Set your active dot color here
                        dotColor: ColorsTheme
                            .secondary, // Set your inactive dot color here
                      ),
                      controller: _controller,
                      count: numberOfIntroPage),

                  // Next button
                  isOnLastPage
                      ? GestureDetector(
                          onTap: () {
                            
                          },
                          child: Text(context.localizations.done,
                              style: textTheme.labelMedium
                                  ?.copyWith(color: ColorsTheme.white)),
                        )
                      : GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          },
                          child: Text(context.localizations.next,
                              style: textTheme.labelMedium
                                  ?.copyWith(color: ColorsTheme.white)),
                        )
                ],
              ))
        ],
      ),
    );
  }
}
