import 'package:arkanstore_app/core/images/app_images.dart';
import 'package:arkanstore_app/core/theme/colors.dart';
import 'package:arkanstore_app/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../core/widgets/buttonCompo.dart';
import '../../../../../../core/widgets/textfeildCompo.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String phoneNumber;

  const ResetPasswordScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                AppImages.resetpasswordanimation,
                fit: BoxFit.fill,
              ),
              Align(
                child: Text(
                  'إعادة تعيين كلمة مرور  $phoneNumber',
                  style: AppStyle.textStyle24.copyWith(color: AppColors.largeTextColor),
                ),
              ),
              const SizedBox(height: 20),
               CustomTextField(
                hintText: 'كلمة المرور الجديدة',
                prefixIcon: Icons.lock,
                isPassword: true,
                borderRadius: 20,
                borderColor: AppColors.SecondaryColor,
              ),
              const SizedBox(height: 15),
               CustomTextField(
                hintText: 'تأكيد كلمة المرور',
                prefixIcon: Icons.lock,
                isPassword: true,
                borderRadius: 20,
                borderColor: AppColors.SecondaryColor,
              ),
              const SizedBox(height: 30),
              CustomMaterialButton(
                onPressed: (){},
                buttonText: 'تأكيد',
                buttonColor: AppColors.SecondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
