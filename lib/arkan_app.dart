import 'package:arkanstore_app/features/categories_feature/presentation/bloc/category/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/DI/service_locator.dart';
import 'core/Routing/routes.dart';
import 'core/theme/colors.dart';
import 'features/adress_feature/bloc/adress_cubit.dart';
import 'features/auth_feature/presentation/login/bloc/login_cubit.dart';
import 'features/auth_feature/presentation/profile/bloc/profile_cubit.dart';
import 'features/auth_feature/presentation/register/bloc/register_cubit.dart';
import 'features/banner_feature/presentation/bloc/banner_cubit.dart';
import 'features/categories_feature/presentation/bloc/product/product_cubit.dart';
import 'features/fav_feature/presentation/bloc/fav_cubit.dart';
import 'features/home_feature/presentaion/home/view/homeScreen.dart';

class ArkanApp extends StatelessWidget {
  const ArkanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<LoginCubit>(
              create: (context) => sl<LoginCubit>(),
            ),
            BlocProvider<RegisterCubit>(
              create: (context) => sl<RegisterCubit>(),
            ),
            BlocProvider<ProfileCubit>(
              create: (context) => sl<ProfileCubit>()
                ..fetchUserProfile()
                ..updateUserProfile,
            ),
            BlocProvider<AddressCubit>(create: (context) => AddressCubit()),
            BlocProvider<CategoryBloc>(
                create: (context) => sl<CategoryBloc>()..fetchCategories()),
            BlocProvider<ProductCubit>(create: (context) => sl<ProductCubit>()),
            BlocProvider<FavoriteCubit>(
                create: (context) => sl<FavoriteCubit>()),
            BlocProvider<BannerCubit>(create: (context) => sl<BannerCubit>()..fetchBanners()),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            builder: (BuildContext context, Widget? child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child!,

              );
            },
            routerConfig: AppRouter.router,
            theme: ThemeData(
              primaryColor: AppColors.SecondaryColor,
              fontFamily: GoogleFonts.notoSans().fontFamily,
            ),

          ),
        );
      },
    );
  }
}
