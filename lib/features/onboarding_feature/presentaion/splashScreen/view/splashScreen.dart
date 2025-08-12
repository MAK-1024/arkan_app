import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/Routing/routes.dart';
import '../../../../../core/helpers/SharedPrefsHelper.dart';
import '../../../../../core/images/app_images.dart';
import '../../../../../core/theme/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  final SharedPrefsHelper _sharedPrefsHelper = SharedPrefsHelper();

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _navigateToNextScreen();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));

    // Fetch onboarding status and token using SharedPrefsHelper
    final bool onboardingCompleted = await _sharedPrefsHelper.isOnboardingCompleted();
    final String? token = await _sharedPrefsHelper.getToken();

    if (!onboardingCompleted) {
      // User has not completed onboarding
      GoRouter.of(context).pushReplacement(AppRouter.onBoardingScreen);
    } else if (token != null && token.isNotEmpty) {
      // User is logged in
      GoRouter.of(context).pushReplacement(AppRouter.homePageScreen);
    } else {
      // User is not logged in
      GoRouter.of(context).pushReplacement(AppRouter.loginScreen);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Semantics(
                    label: 'Arkan Store Logo',
                    child: Image.asset(AppImages.arkanLogo),
                  ),
                  SizedBox(height: 25.h),
                  Text(
                    'متجر أركان',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.SecondaryColor2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
