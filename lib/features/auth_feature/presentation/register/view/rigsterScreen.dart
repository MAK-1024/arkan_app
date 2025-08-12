import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/Routing/routes.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/style.dart';
import '../../../../../core/widgets/buttonCompo.dart';
import '../../../../../core/widgets/textfeildCompo.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _repassWordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.r),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    'إنشاء حساب',
                    style: AppStyle.textStyle32.copyWith(
                      color: AppColors.largeTextColor,
                    ),
                  ),
                  const Text(
                    'أدخل بياناتك الشخصية',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.smallTextColor,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    onChange: (name) {
                      _nameController.text = name!;
                    },
                    hintText: 'الاسم بالكامل',
                    prefixIcon: Icons.person,
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    validator: (value) => value == null || value.isEmpty
                        ? 'الرجاء ادخال الاسم بالكامل'
                        : null,
                    borderRadius: 40,
                    borderColor: AppColors.SecondaryColor,
                    textInputAction: TextInputAction.next,
                  ),
                  CustomTextField(
                    onChange: (email) {
                      _emailController.text = email!;
                    },
                    hintText: 'الحساب الاكتروني',
                    prefixIcon: Icons.email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال الحساب الالكتروني';
                      }
                      if (!value.contains('@')) {
                        return 'الرجاء ادخال بريد إلكتروني صحيح';
                      }
                      return null;
                    },
                    borderRadius: 40,
                    borderColor: AppColors.SecondaryColor,
                    textInputAction: TextInputAction.next,
                  ),
                  CustomTextField(
                    onChange: (phone) {
                      _phoneController.text = phone!;
                    },
                    hintText: 'رقم الهاتف : 09xxxxxxxx',
                    prefixIcon: Icons.phone,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال رقم الهاتف';
                      }
                      if (!RegExp(r'^09[1-4][0-9]{7}$').hasMatch(value)) {
                        return 'رقم الهاتف غير صالح';
                      }
                      return null;
                    },
                    borderRadius: 40,
                    borderColor: AppColors.SecondaryColor,
                    textInputAction: TextInputAction.next,
                  ),
                  CustomTextField(
                    onChange: (password) {
                      _passWordController.text = password!;
                    },
                    hintText: 'كلمة المرور',
                    prefixIcon: Icons.lock,
                    controller: _passWordController,
                    validator: (value) => value == null || value.isEmpty
                        ? 'الرجاء ادخال كلمة المرور'
                        : null,
                    borderRadius: 40,
                    borderColor: AppColors.SecondaryColor,
                    isPassword: true,
                    textInputAction: TextInputAction.next,
                  ),
                  CustomTextField(
                    onChange: (password) {
                      _repassWordController.text = password!;
                    },
                    hintText: 'تأكيد كلمة المرور',
                    prefixIcon: Icons.lock,
                    controller: _repassWordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء تأكيد كلمة المرور';
                      }
                      if (value != _passWordController.text) {
                        return 'كلمات المرور غير مطابقة';
                      }
                      return null;
                    },
                    isPassword: true,
                    borderRadius: 40,
                    borderColor: AppColors.SecondaryColor,
                    textInputAction: TextInputAction.next,
                  ),
                  CustomTextField(
                    onChange: (dob) {
                      _dateOfBirthController.text = dob!;
                    },
                    hintText: 'تاريخ الميلاد',
                    prefixIcon: Icons.calendar_today,
                    controller: _dateOfBirthController,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        builder: (context, child) => Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.light(
                              primary: AppColors.SecondaryColor,
                            ),
                          ),
                          child: child!,
                        ),
                      );
                      if (pickedDate != null) {
                        _dateOfBirthController.text =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                      }
                    },
                    validator: (value) => value == null || value.isEmpty
                        ? 'الرجاء ادخال تاريخ الميلاد'
                        : null,
                    borderRadius: 40,
                    borderColor: AppColors.SecondaryColor,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 28.h),
                  CustomMaterialButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        GoRouter.of(context).push(AppRouter.otpScreen2);
                      }
                    },
                    buttonText: 'إنشاء الحساب ',
                    buttonColor: AppColors.SecondaryColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'هل لديك حساب ؟',
                        style: TextStyle(
                          color: AppColors.smallTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context)
                              .pushReplacement(AppRouter.loginScreen);
                        },
                        child: const Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            color: AppColors.MainColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
