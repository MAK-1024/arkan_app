import 'package:arkanstore_app/core/Routing/routes.dart';
import 'package:arkanstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../../../core/widgets/buttonCompo.dart';


class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> with CodeAutoFill {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _requestSmsPermission();
    listenForCode(); // Start listening for OTP in this screen as well
  }

  Future<void> _requestSmsPermission() async {
    final status = await Permission.sms.request();
    if (status.isGranted) {
      // Permission granted, proceed
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission to read SMS is required for autofill')),
      );
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  void codeUpdated() {
    // This method won't be used here, but it's required by the CodeAutoFill mixin
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('أدخل رقم الهاتف'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'رقم الهاتف',
                  hintStyle: TextStyle(color: AppColors.largeTextColor),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال رقم الهاتف';
                  }
                  final RegExp regex = RegExp(r'^2189[1-4][0-9]{7}$');
                  if (!regex.hasMatch(value)) {
                    return 'رقم الهاتف غير صالح';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomMaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Pass the phone number to the OTPScreen
                    GoRouter.of(context).pushReplacement(
                      AppRouter.otpScreen2,
                      extra: _phoneNumberController.text,
                    );
                  }
                },
                buttonText: 'إرسال رمز التحقق',
                buttonColor: AppColors.SecondaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}