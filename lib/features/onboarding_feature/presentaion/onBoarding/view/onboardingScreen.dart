import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/Routing/routes.dart';
import 'widget/OnboardingPage1.dart';
import 'widget/OnboardingPage2.dart';
import 'widget/OnboardingPage3.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _pageCount = 3;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkOnboardingCompletion();
    });
  }

  Future<void> _checkOnboardingCompletion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasViewedOnboarding = prefs.getBool('onboardingCompleted') ?? false;

    if (hasViewedOnboarding) {
      GoRouter.of(context).pushReplacement(AppRouter.loginScreen);
    }
  }

  Future<void> _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingCompleted', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              OnboardingPage1(),
              OnboardingPage2(),
              OnboardingPage3(),
            ],
          ),
          if (_currentPage == 2)
            Positioned(
              bottom: 60.h,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await _completeOnboarding();
                    GoRouter.of(context).pushReplacement(AppRouter.loginScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 28.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'إبدأ التسوق',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            top: 30.h,
            left: 20.w,
            child: TextButton(
              onPressed: () async {
                await _completeOnboarding();
                GoRouter.of(context).pushReplacement(AppRouter.loginScreen);
              },
              child: Row(
                children: [
                  Text(
                    'تخطي',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 16.sp,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          if (_currentPage != 2)
            Positioned(
              bottom: 70.h,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: _pageCount,
                  effect: SwapEffect(
                    activeDotColor: Colors.white,
                    dotColor: Colors.white.withOpacity(0.5),
                    dotWidth: 25.w,
                    dotHeight: 10.h,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
