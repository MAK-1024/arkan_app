import 'dart:io';

import 'package:arkanstore_app/core/Routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/widgets/textfeildCompo.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';

class EditProfileScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _imagePath;

  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileCubit>(context).fetchUserProfile();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("إعدادات الحساب", style: TextStyle(fontSize: 18.sp)),
        backgroundColor: AppColors.appBarColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(25.r),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text(state.message)),
              // );
            } else if (state is ProfileLoaded) {
              _nameController.text = state.userProfile.name;
              _emailController.text = state.userProfile.email;
              _phoneController.text = state.userProfile.phone!;
            } else if (state is ProfileUpdated) {
              toastification.show(
                context: context,
                style: ToastificationStyle.flat,
                type: ToastificationType.success,
                title: const Text('! تم تحديث الملف الشخصي بنجاح'),
                autoCloseDuration: const Duration(seconds: 3),
                alignment: Alignment.topCenter,
                icon: const Icon(Icons.check_circle_outline),
                closeOnClick: true,
              );
              GoRouter.of(context).go(AppRouter.homePageScreen);

            }
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Skeletonizer(
                enabled: true,
                child: _buildSkeleton(),
              );
            }
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProfileImage(context),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      hintText: "رقم الهاتف",
                      borderRadius: 30.r,
                      borderColor: AppColors.SecondaryColor,
                      enabled: false,
                      controller: _phoneController,
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      hintText: "الاسم واللقب",
                      borderRadius: 30.r,
                      borderColor: AppColors.SecondaryColor,
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء ادخال الاسم واللقب';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      hintText: "البريد الالكتروني",
                      borderRadius: 30.r,
                      borderColor: AppColors.SecondaryColor,
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء ادخال البريد الالكتروني';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'الرجاء ادخال بريد الكتروني صالح';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        Icon(Icons.lock_open),
                        SizedBox(
                          width: 5,
                        ),
                        TextButton(
                            onPressed: () {
                              GoRouter.of(context)
                                  .push(AppRouter.changePasswordScreen);
                            },
                            child: Text('تغيير كلمة المرور' , style: TextStyle(color: AppColors.MainColor),))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.SecondaryColor,
                          width: 2.0.w,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final updatedFields = {
                              'name': _nameController.text,
                              'email': _emailController.text,
                            };
                            context
                                .read<ProfileCubit>()
                                .updateUserProfile(updatedFields);
                          }
                        },
                        child: Text(
                          "حفظ التعديلات ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.SecondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return GestureDetector(
      // onTap: () => _pickImage(context),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 60.r,
            backgroundColor: Colors.white,
            backgroundImage: _imagePath != null
                ? FileImage(File(_imagePath!))
                : AssetImage(AppImages.arkanLogo) as ImageProvider,
          ),
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   child: CircleAvatar(
          //     radius: 20.r,
          //     backgroundColor: Colors.white,
          //     child: Icon(
          //       Icons.edit,
          //       color: AppColors.MainColor,
          //       size: 20.r,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildSkeleton() {
    return SingleChildScrollView(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60.r,
            backgroundColor: Colors.grey[300],
          ),
          SizedBox(height: 20.h),
          _buildSkeletonTextField(),
          SizedBox(height: 10.h),
          _buildSkeletonTextField(),
          SizedBox(height: 10.h),
          _buildSkeletonTextField(),
          SizedBox(height: 30.h),
          Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(30.r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonTextField() {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(30.r),
      ),
    );
  }

  void _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imagePath = pickedFile.path;
    }
  }
}
