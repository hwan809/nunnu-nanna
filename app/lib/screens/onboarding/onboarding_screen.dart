// lib/screens/onboarding/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/onboarding_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (_currentPage == 5) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
          )
        )
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: size.height * 0.1),
                child: SmoothPageIndicator(
                  controller: _pageController,  // PageController
                  count: 5,
                  effect: const WormEffect(
                    dotHeight: 15,
                    dotWidth: 15,
                    radius: 90,
                    activeDotColor: Color(0xFF7BD3EA)
                  ),  // your preferred effect
                )
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingPages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  final data = onboardingPages[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.1),
                        Text(
                          data.title,
                          style: TextStyle(
                            fontFamily: 'Cafe24OhSquare',
                            fontSize: size.width * 0.06,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -2.5,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: size.width * 0.02),
                        Text(
                          data.subtitle,
                          style: TextStyle(
                            fontFamily: 'Cafe24OhSquare',
                            fontSize: size.width * 0.045,
                            fontWeight: FontWeight.w300,
                            letterSpacing: -2.5,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: size.height * 0.1),
                        SvgPicture.asset(
                          data.imagePath,
                          height: size.width*0.3,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.1,
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.1,
                  vertical: size.width * 0.15
              ),
              child: ElevatedButton(
                onPressed: () {
                  _currentPage += 1;
                  if (_currentPage == 4 + 1) {
                    _currentPage = 0;
                  }
                  _pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7BD3EA),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90),
                  ),
                ),
                child: Text(
                  '다음',
                  style: TextStyle(
                    fontFamily: 'Cafe24OhSquare',
                    color: Colors.white,
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}