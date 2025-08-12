import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/Routing/routes.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/widgets/textfeildCompo.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';


class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdated) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Password updated successfully!'),
            backgroundColor: Colors.green,
          ));
          // Optionally, navigate away or clear the fields
          Navigator.of(context).pop(); // Close the screen or navigate back
        } else if (state is ProfileError) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red,
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("تغيير كلمة المرور"),
          ),
          body: Padding(
            padding: EdgeInsets.all(20.r),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'كلمة المرور القديمة',
                      prefixIcon: Icons.key,
                      controller: _oldPasswordController,
                      onChange: (value) {},
                      borderRadius: 30.r,
                      borderColor: AppColors.MainColor,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال كلمة السر القديمة';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    CustomTextField(
                      hintText: 'كلمة المرور الجديدة',
                      prefixIcon: Icons.key,
                      controller: _newPasswordController,
                      onChange: (value) {},
                      borderRadius: 30.r,
                      borderColor: AppColors.MainColor,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال كلمة السر الجديدة';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.h),
                    CustomTextField(
                      hintText: 'تأكيد كلمة المرور الجديدة',
                      prefixIcon: Icons.key,
                      controller: _confirmPasswordController,
                      onChange: (value) {},
                      borderRadius: 30.r,
                      borderColor: AppColors.MainColor,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء تأكيد كلمة السر الجديدة';
                        }
                        if (value != _newPasswordController.text) {
                          return 'كلمات المرور غير متطابقة';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.h),
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
                            // Get the new password from the controller
                            final newPassword = _newPasswordController.text;

                            // Call the updatePassword method from the ProfileCubit
                            BlocProvider.of<ProfileCubit>(context).updateUserProfile({
                              'password': newPassword,
                            });
                          }
                        },
                        child: Text(
                          "تغيير كلمة المرور ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.SecondaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          GoRouter.of(context).push(AppRouter.forgotPasswordScreen);
                        },
                        child: Text(
                          'نسيت كلمة المرور؟',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.smallTextColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
  }
}
