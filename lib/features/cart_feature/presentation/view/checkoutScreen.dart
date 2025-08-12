import 'package:arkanstore_app/core/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/widgets/textfeildCompo.dart';


class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;
  final _formKey1 = GlobalKey<FormState>();
  String _name = '';
  String _phoneNumber = '';
  String _address = '';
  String _selectedPaymentMethod = 'الدفع عند الاستلام';
  bool _saveInfoForFuture = false;
  bool _isAlternativeReceiver = false;
  String _receiverName = '';
  String _receiverPhoneNumber = '';
  String _receiverAddress = '';

  final List<Map<String, dynamic>> _cartItems = [
    {'name': 'ماوس ألعاب', 'price': 50.0, 'quantity': 1},
    {'name': 'لوحة مفاتيح ألعاب', 'price': 80.0, 'quantity': 1},
    {'name': 'ماوس ألعاب', 'price': 50.0, 'quantity': 1},
    {'name': 'لوحة مفاتيح ألعاب', 'price': 80.0, 'quantity': 1},
    {'name': 'ماوس ألعاب', 'price': 50.0, 'quantity': 1},
    {'name': 'لوحة مفاتيح ألعاب', 'price': 80.0, 'quantity': 1},
  ];

  List<String> _savedAddresses = [];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _saveInfoForFuture = prefs.getBool('saveInfo') ?? false;
      if (_saveInfoForFuture) {
        _name = prefs.getString('name') ?? '';
        _phoneNumber = prefs.getString('phoneNumber') ?? '';
      }
      _savedAddresses = prefs.getStringList('addresses') ?? [];
    });
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('saveInfo', _saveInfoForFuture);
    if (_saveInfoForFuture) {
      await prefs.setString('name', _name);
      await prefs.setString('phoneNumber', _phoneNumber);
    }
  }

  void _submitOrder() {
    if (_formKey1.currentState!.validate()) {
      print('Order Submitted!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text(
      //     'إتمام الشراء',
      //     style: TextStyle(
      //       fontSize: 20.sp,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Stepper(
                  elevation: 2,
                  connectorThickness: 3,
                  connectorColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey;
                    } else {
                      return AppColors.SecondaryColor;
                    }
                  }),
                  type: StepperType.horizontal,
                  currentStep: _currentStep,
                  onStepContinue: () {
                    if (_currentStep == 0 &&
                        _formKey1.currentState!.validate()) {
                      _formKey1.currentState!.save();
                      setState(() => _currentStep++);
                    } else if (_currentStep == 1) {
                      setState(() => _currentStep++);
                    } else if (_currentStep == 2) {
                      _submitOrder();
                    }
                  },
                  onStepCancel: _currentStep > 0
                      ? () => setState(() => _currentStep--)
                      : null,
                  onStepTapped: (int index) =>
                      setState(() => _currentStep = index),
                  steps: [
                    Step(
                      title: Text(
                        'العنوان',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: _buildAddressForm(),
                      isActive: _currentStep == 0,
                    ),
                    Step(
                      title: Text(
                        'ملخص الطلب',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: _buildOrderSummarySection(),
                      isActive: _currentStep == 1,
                    ),
                    Step(
                      title: Text(
                        'الدفع',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: _buildPaymentSection(),
                      isActive: _currentStep == 2,
                    ),
                  ],
                  controlsBuilder:
                      (BuildContext context, ControlsDetails controlsDetails) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: controlsDetails.onStepContinue,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30.w,
                                vertical: 15.h,
                              ),
                              backgroundColor:
                                  AppColors.SecondaryColor.withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                            ),
                            child: Text(
                              _currentStep == 2 ? 'إتمام الطلب' : 'التالي',
                              style: TextStyle(
                                color: AppColors.SecondaryColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          if (_currentStep > 0)
                            OutlinedButton(
                              onPressed: controlsDetails.onStepCancel,
                              style: OutlinedButton.styleFrom(
                                side:
                                    BorderSide(color: AppColors.SecondaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15.h),
                              ),
                              child: Text(
                                'السابق',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.SecondaryColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressForm() {
    return Container(
      width: 300.w, // Adjust the width for horizontal layout
      child: Form(
        key: _formKey1,
        child: Column(
          children: [
            CustomTextField(
              hintText: 'الاسم بالكامل',
              onChange: (value) {
                _name = value!;
              },
              borderRadius: 30,
              borderColor: AppColors.SecondaryColor,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء ادخال الاسم';
                } else if (value.length < 3) {
                  return 'الاسم يجب أن يكون أكثر من 3 أحرف';
                }
                return null;
              },
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              hintText: 'رقم الهاتف',
              onChange: (value) {
                _phoneNumber = value!;
              },
              borderRadius: 30,
              borderColor: AppColors.SecondaryColor,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء ادخال رقم الهاتف';
                } else if (!RegExp(r'^2189[1-4][0-9]{7}$').hasMatch(value)) {
                  return 'رقم الهاتف غير صالح';
                }
                return null;
              },
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              hintText: 'المدينة',
              onChange: (value) {
                _name = value!;
              },
              borderRadius: 30,
              borderColor: AppColors.SecondaryColor,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء ادخال المدينة';
                // } else if (value.length < 3) {
                //   return 'الاسم يجب أن يكون أكثر من 3 أحرف';
                }
                return null;
              },
            ),
            SizedBox(height: 12.h),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'اختر عنوانك',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              value: _address.isNotEmpty ? _address : null,
              items: _savedAddresses.map((address) {
                return DropdownMenuItem(
                  value: address,
                  child: Text(address),
                );
              }).toList(),
              onChanged: (value) => setState(() => _address = value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء اختيار العنوان';
                }
                return null;
              },
            ),
            CheckboxListTile(
              checkColor: AppColors.MainColor,
              activeColor: Colors.grey[300],
              title: Text(
                'مستلم بديل في حالة لم يتم الوصول إليك',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
              ),
              value: _isAlternativeReceiver,
              onChanged: (value) {
                setState(() {
                  _isAlternativeReceiver = value!;
                  if (!value) {
                    _receiverName = '';
                    _receiverPhoneNumber = '';
                    _receiverAddress = '';
                  }
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            if (_isAlternativeReceiver) ...[
              CustomTextField(
                hintText: 'اسم المستلم',
                onChange: (value) {
                  _receiverName = value!;
                },
                borderRadius: 30,
                borderColor: AppColors.SecondaryColor,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء ادخال اسم المستلم';
                  } else if (value.length < 3) {
                    return 'الاسم يجب أن يكون أكثر من 3 أحرف';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                hintText: 'رقم هاتف المستلم',
                onChange: (value) {
                  _receiverPhoneNumber = value!;
                },
                borderRadius: 30,
                borderColor: AppColors.SecondaryColor,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء ادخال رقم الهاتف';
                  } else if (!RegExp(r'^2189[1-4][0-9]{7}$').hasMatch(value)) {
                    return 'رقم الهاتف غير صالح';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                hintText: 'المدينة',
                onChange: (value) {
                  _name = value!;
                },
                borderRadius: 30,
                borderColor: AppColors.SecondaryColor,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء ادخال المدينة';
                    // } else if (value.length < 3) {
                    //   return 'الاسم يجب أن يكون أكثر من 3 أحرف';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                hintText: 'عنوان المستلم',
                onChange: (value) {
                  _receiverAddress = value!;
                },
                borderRadius: 30,
                borderColor: AppColors.SecondaryColor,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء ادخال العنوان';
                  }
                  return null;
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummarySection() {
    return Container(
      width: 300.w,
      child: Column(
        children: [
          ..._cartItems.map(
            (item) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item['name'],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${item['quantity']} × ${item['price']}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Divider(color: Colors.grey[300]),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المجموع الجزئي:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '260.00',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.MainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'تكلفة التوصيل:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '5.00',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.MainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Divider(color: Colors.grey[300]),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المجموع الكلي:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '265.00',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: AppColors.MainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Container(
      width: 300.w, // Adjust the width for horizontal layout
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'اختر طريقة الدفع:',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            value: _selectedPaymentMethod,
            items: [
              'الدفع عند الاستلام',
              'الدفع عبر المحفظة',
              'الدفع في المتجر',
              'الدفع عبر الإنترنت'
            ].map((method) {
              return DropdownMenuItem(
                value: method,
                child: Text(method),
              );
            }).toList(),
            onChanged: (value) =>
                setState(() => _selectedPaymentMethod = value!),
          ),
          SizedBox(height: 20.h),
          if (_selectedPaymentMethod == 'الدفع عبر المحفظة' ||
              _selectedPaymentMethod == 'الدفع عبر الإنترنت')
            Column(
              children: [
                CustomTextField(
                  hintText: 'اسم صاحب الحساب',
                  onChange: (value) {
                    _name = value!;
                  },
                  borderRadius: 30,
                  borderColor: AppColors.SecondaryColor,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء ادخال الاسم';
                    } else if (value.length < 3) {
                      return 'الاسم يجب أن يكون أكثر من 3 أحرف';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12.h),
                CustomTextField(
                  hintText: 'رقم بطاقة الدفع',
                  onChange: (value) {
                    _phoneNumber = value!;
                  },
                  borderRadius: 30,
                  borderColor: AppColors.SecondaryColor,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء ادخال رقم البطاقة';
                    } else if (value.length < 16 || value.length > 16) {
                      return 'رقم البطاقة يجب أن يكون 16 رقمًا';
                    }
                    return null;
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
