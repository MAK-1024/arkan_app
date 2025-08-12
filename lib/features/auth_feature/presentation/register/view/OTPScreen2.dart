import 'package:arkanstore_app/core/Routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../../core/images/app_images.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/theme/style.dart';
import '../../../../../../core/widgets/buttonCompo.dart';

class OTPScreen2 extends StatefulWidget {
  const OTPScreen2({
    Key? key,
  }) : super(key: key);

  @override
  _OTPScreen2State createState() => _OTPScreen2State();
}

class _OTPScreen2State extends State<OTPScreen2> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(AppImages.otpanimation),
                  SizedBox(height: 20.h),
                  Text(
                    'ادخل رمز التحقق',
                    style: AppStyle.textStyle24
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'تم ارسال رمز التحقق المكون من اربعة ارقام الى رقم الهاتف: ${'0910000000'}',
                    style: AppStyle.textStyle16
                        .copyWith(color: AppColors.largeTextColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  PinCodeTextField(
                    length: 4,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(15.r),
                      fieldHeight: 60.h,
                      fieldWidth: 50.w,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      activeColor: AppColors.SecondaryColor,
                      selectedColor: AppColors.SecondaryColor,
                      inactiveColor: AppColors.SecondaryColor,
                    ),
                    cursorColor: AppColors.SecondaryColor,
                    controller: _otpController,
                    onChanged: (value) {},
                    appContext: context,
                    enableActiveFill: true,
                  ),
                  SizedBox(height: 20.h),
                  CustomMaterialButton(
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.resetPasswordScreen);

                      },
                    buttonText: 'تأكيد رمز التحقق',
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
