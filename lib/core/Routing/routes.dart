import 'package:arkanstore_app/features/onboarding_feature/presentaion/splashScreen/view/splashScreen.dart';
import 'package:go_router/go_router.dart';
import '../../features/adress_feature/view/addLocationScreen.dart';
import '../../features/adress_feature/view/adrressScreen.dart';
import '../../features/auth_feature/presentation/profile/view/profileScreen.dart';
import '../../features/cart_feature/presentation/view/cartScreen.dart';
import '../../features/cart_feature/presentation/view/checkoutScreen.dart';
import '../../features/categories_feature/presentation/view/categories.dart';
import '../../features/categories_feature/presentation/view/producstById.dart';
import '../../features/home_feature/presentaion/home/view/OrderDetailsScreen.dart';
import '../../features/home_feature/presentaion/home/view/homeScreen.dart';
import '../../features/onboarding_feature/presentaion/onBoarding/view/onboardingScreen.dart';
import '../../features/auth_feature/presentation/login/view/loginscreen.dart';
import '../../features/auth_feature/presentation/register/view/OTPScreen2.dart';
import '../../features/auth_feature/presentation/register/view/ResetPasswordScreen.dart';
import '../../features/auth_feature/presentation/register/view/forgePasswordScreen.dart';
import '../../features/auth_feature/presentation/register/view/phoneNumberScreen.dart';
import '../../features/auth_feature/presentation/register/view/rigsterScreen.dart';
import '../../presentation/contactUsScreen/view/ContactUsScreen.dart';
import '../../features/fav_feature/presentation/view/favorite.dart';
import '../../presentation/search/view/searchScreen.dart';
import '../../presentation/notification/view/notificationSccreen.dart';
import '../../features/auth_feature/presentation/profile/view/changePasswordScreen.dart';
import '../../features/auth_feature/presentation/profile/view/editProfileScreen.dart';
import '../../presentation/about/view/aboutScreen.dart';

abstract class AppRouter {
  static const String splashScreen = "/";
  static const String onBoardingScreen = "/onboarding";
  static const String loginScreen = "/login";
  static const String registerScreen = "/register";
  static const String homePageScreen = "/home";
  static const String otpScreen2 = "/otp2";
  static const String phoneNumberScreen = "/phone";
  static const String forgotPasswordScreen = "/forgot-password";
  static const String resetPasswordScreen = "/reset-password";
  static const String categoryScreen = "/categories";
  static const String favoriteScreen = "/FavoriteScreen";
  static const String notificationScreen = "/notifications";
  static const String staticCheckoutScreen = "/staticCheckoutScreen";
  static const String addressScreen = "/addressScreen";
  static const String aboutScreen = "/about";
  static const String editProfileScreen = "/edit-profile";
  static const String changePasswordScreen = "/change-password";
  static const String searchScreen = "/search";
  static const String contactUsScreen = "/contact-us";
  static const String orderDetailsScreen = "/order-details";
  static const String profileScreen = "/profileScreen";
  static const String addLocationScreen = "/AddLocationScreen";
  static const String addLocationInfoScreen = "/AddLocationInfoScreen";
  static const String productsScreen = "/productsScreen";

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: splashScreen,
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: onBoardingScreen,
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        path: loginScreen,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: registerScreen,
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: homePageScreen,
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: otpScreen2,
        builder: (context, state) => OTPScreen2(),
      ),
      GoRoute(
        path: phoneNumberScreen,
        builder: (context, state) => PhoneNumberScreen(),
      ),
      GoRoute(
        path: forgotPasswordScreen,
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: resetPasswordScreen,
        builder: (context, state) {
          final phoneNumber = state.extra as String? ?? '';
          return ResetPasswordScreen(phoneNumber: phoneNumber);
        },
      ),
      GoRoute(
        path: categoryScreen,
        builder: (context, state) => CategoriesScreen(),
      ),
      GoRoute(
        path: favoriteScreen,
        builder: (context, state) => FavoriteScreen(),
      ),
      GoRoute(
        path: notificationScreen,
        builder: (context, state) => NotificationScreen(),
      ),
      GoRoute(
        path: staticCheckoutScreen,
        builder: (context, state) => StaticCheckoutScreen(),
      ),
      GoRoute(
        path: addressScreen,
        builder: (context, state) => AddressScreen(),
      ),
      GoRoute(
        path: addLocationScreen,
        builder: (context, state) => AddLocationScreen(),
      ),
      GoRoute(
        path: aboutScreen,
        builder: (context, state) => AboutScreen(),
      ),
      GoRoute(
        path: editProfileScreen,
        builder: (context, state) => EditProfileScreen(),
      ),
      GoRoute(
        path: changePasswordScreen,
        builder: (context, state) => ChangePasswordScreen(),
      ),
      GoRoute(
        path: searchScreen,
        builder: (context, state) => SearchScreen(),
      ),
      GoRoute(
        path: contactUsScreen,
        builder: (context, state) => ContactUsScreen(),
      ),
      GoRoute(
        path: orderDetailsScreen,
        builder: (context, state) => OrderDetailsScreen(),
      ),
      GoRoute(
        path: profileScreen,
        builder: (context, state) => ProfileScreen(),
      ),
      GoRoute(
        path: productsScreen,
        builder: (context, state) {
          final arr = state.extra as Map<String, dynamic>;

          return ProductsScreen(
            categoryId: arr['id'],
            categoryName: arr['name'],
          );
        },
      ),
    ],
  );
}
