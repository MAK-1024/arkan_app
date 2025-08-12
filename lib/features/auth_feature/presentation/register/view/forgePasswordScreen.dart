import 'package:arkanstore_app/core/Routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/widgets/buttonCompo.dart';
import '../../../../../../core/widgets/textfeildCompo.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 80.h),
                  Center(
                    child: Lottie.network(
                      'https://lottie.host/ef5e3331-3f68-4c64-9985-dcdbf61f6e6e/vM4PQUEOkV.json',
                      width: 150.w,
                      height: 150.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'ادخل رقم هاتفك',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.largeTextColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    controller: _phoneController,
                    hintText: 'رقم الهاتف',
                    prefixIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال رقم الهاتف';
                      }
                      final RegExp regex = RegExp(r'^09[12][0-9]{7}$');
                      if (!regex.hasMatch(value)) {
                        return 'رقم الهاتف غير صالح';
                      }
                      return null;
                    },
                    onChange: (_) {},
                    borderRadius: 40.r,
                    borderColor: AppColors.SecondaryColor,
                  ),
                  SizedBox(height: 30.h),
                  CustomMaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        GoRouter.of(context).push(
                          AppRouter.otpScreen2,);
                      }
                    },
                    buttonText: 'ارسال الرمز',
                    buttonColor: AppColors.SecondaryColor,
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
