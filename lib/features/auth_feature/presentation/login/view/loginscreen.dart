import 'package:arkanstore_app/core/images/app_images.dart';
import 'package:arkanstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/Routing/routes.dart';
import '../../../../../core/theme/style.dart';
import '../../../../../core/widgets/buttonCompo.dart';
import '../../../../../core/widgets/textfeildCompo.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.SecondaryColor, AppColors.SecondaryColor],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Image.asset(
                  AppImages.loginanimation,
                  fit: BoxFit.fill,
                  height: 220.h,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.r),
                      topRight: Radius.circular(35.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 15.h),
                            Text(
                              'تسجيل الدخول',
                              style: AppStyle.textStyle32.copyWith(
                                color: AppColors.largeTextColor,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              'أدخل رقم الهاتف وكلمة المرور',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.smallTextColor,
                              ),
                            ),
                            SizedBox(height: 20.h),
                        
                            /// Phone Field
                            CustomTextField(
                              keyboardType: TextInputType.number,
                              controller: _nameController,
                              hintText: ' رقم الهاتف : 09xxxxxxx',
                              prefixIcon: Icons.person,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء ادخال رقم الهاتف';
                                }
                                return null;
                              },
                              onChange: (val) {},
                              textInputAction: TextInputAction.next,
                              borderRadius: 40,
                              borderColor: AppColors.SecondaryColor,
                            ),
                        
                            SizedBox(height: 10.h),
                        
                            CustomTextField(
                              controller: _passwordController,
                              keyboardType: TextInputType.text,
                              hintText: 'كلمة المرور',
                              prefixIcon: Icons.key,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرجاء ادخال كلمة المرور';
                                }
                                return null;
                              },
                              isPassword: true,
                              onChange: (val) {},
                              textInputAction: TextInputAction.done,
                              borderRadius: 40,
                              borderColor: AppColors.SecondaryColor,
                              onFieldSubmitted: (value) {
                                if (_formKey.currentState!.validate()) {
                                  GoRouter.of(context).pushReplacement(AppRouter.homePageScreen);
                                }
                              },
                            ),
                        

                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  GoRouter.of(context).push(AppRouter.forgotPasswordScreen);
                                },
                                child: Text(
                                  'هل   نسيت كلمة المرور؟',
                                  style: TextStyle(
                                    color: AppColors.MainColor,
                                    fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                        
                            SizedBox(height: 10.h),
                        
                            CustomMaterialButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  GoRouter.of(context).pushReplacement(AppRouter.homePageScreen);
                                }
                              },
                              buttonText: 'تسجيل الدخول',
                              buttonColor: AppColors.SecondaryColor,
                            ),
                        
                            SizedBox(height: 20.h),
                        
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'ليس لديك حساب ؟',
                                  style: TextStyle(
                                    color: AppColors.smallTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    GoRouter.of(context).pushReplacement(AppRouter.registerScreen);
                                  },
                                  child: const Text(
                                    'إنشاء حساب',
                                    style: TextStyle(
                                      color: AppColors.MainColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
