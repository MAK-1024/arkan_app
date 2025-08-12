import 'package:arkanstore_app/core/Routing/routes.dart';
import 'package:arkanstore_app/core/images/app_images.dart';
import 'package:arkanstore_app/features/auth_feature/presentation/profile/view/widget/contactBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/helpers/SharedPrefsHelper.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/widgets/buttonCompo.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';


class ProfileScreen extends StatelessWidget {
  final SharedPrefsHelper _sharedPrefsHelper = SharedPrefsHelper();
  late String? nameText = 'Moukhtar';
  late String? phoneText = 'Aboukhabta';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.SecondaryColor,
        title: Text(
          "الحساب الشخصي",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 30.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            SizedBox(height: 30.h),
            _buildProfileSection(
              "إعدادات الحساب",
              Icons.manage_accounts_outlined,
              AppColors.MainColor,
                  () {
                GoRouter.of(context).push(AppRouter.editProfileScreen);
              },
            ),
            SizedBox(height: 20.h),
            _buildProfileSection(
              "عنواني",
              Icons.location_on_outlined,
              AppColors.MainColor,
                  () {
                GoRouter.of(context).push(AppRouter.addressScreen);
              },
            ),
            SizedBox(height: 20.h),
            _buildProfileSection(
              "تواصل معنا",
              Icons.call_outlined,
              AppColors.MainColor,
                  () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0)),
                  ),
                  builder: (context) => ContactBottomSheet(),
                );
              },
            ),
            SizedBox(height: 20.h),
            _buildProfileSection(
              "تقييم التطبيق",
              Icons.star_border_outlined,
              AppColors.MainColor,
                  () {},
            ),
            SizedBox(height: 20.h),
            _buildProfileSection(
              "من نحن",
              Icons.info_outlined,
              AppColors.MainColor,
                  () {
                GoRouter.of(context).push(AppRouter.aboutScreen);
              },
            ),
            SizedBox(height: 40.h),
            Center(
              child: CustomMaterialButton(
                buttonText: 'تسجيل الخروج',
                onPressed: () {
                  _showLogoutDialog(context);
                },
                buttonColor: AppColors.SecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {

        return Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Skeletonizer(
                // enabled: isLoading,
                child: CircleAvatar(
                  radius: 45.r,
                  backgroundImage:
                AssetImage(AppImages.arkanLogo),
                  backgroundColor: Colors.white,
                ),
              ),
              SizedBox(width: 20.w),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Skeletonizer(
                      child: Container(
                        color: Colors.grey[100] ,
                        child: Text(
                          '$nameText',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.MainColor,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Skeletonizer(
                      child: Container(
                        color:  Colors.grey[300] ,
                        child: Text(
                          "$phoneText",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
  }

  Widget _buildProfileSection(String title, IconData icon, Color iconColor,
      VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 15.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 28.r, color: iconColor),
            SizedBox(width: 15.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 18.r, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Center(
            child: Text(
              'تسجيل خروج',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: Text(
            'هل أنت متأكد من تسجيل الخروج؟',
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              child: Text('إغلاق'),
            ),
            TextButton(
              onPressed: () async {
                // final cubit = BlocProvider.of<LoginCubit>(context);
                // await cubit.logout();
                _sharedPrefsHelper.clearAuthData();
                GoRouter.of(context).pushReplacement(AppRouter.loginScreen);
              },
              style: TextButton.styleFrom(
                  foregroundColor: AppColors.SecondaryColor),
              child: Text('تسجيل الخروج'),
            ),
          ],
        );
      },
    );
  }
}
