import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:arkanstore_app/core/theme/colors.dart';
import 'package:arkanstore_app/features/auth_feature/presentation/profile/view/profileScreen.dart';
import '../../../../cart_feature/presentation/view/cartScreen.dart';
import '../../../../categories_feature/presentation/view/categories.dart';
import 'mainscreen.dart';
import 'orderScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController();
  int _currentIndex = 0;
  List<Widget> screens = [
    MainScreen(),
    CategoriesScreen(),
    CartScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  void _updateIndex(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: screens,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r), // simplified
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: AppColors.SecondaryColor,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                style: GnavStyle.google,
                tabs: const [
                  GButton(icon: Icons.home_outlined, text: 'الرئيسية'),
                  GButton(icon: Icons.category_outlined, text: 'الأقسام'),
                  GButton(icon: Icons.shopping_cart_outlined, text: 'السلة'),
                  GButton(icon: Icons.receipt_outlined, text: 'طلباتي'),
                  GButton(icon: Icons.person_outline, text: 'حسابي'),
                ],
                selectedIndex: _currentIndex,
                onTabChange: _updateIndex,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
