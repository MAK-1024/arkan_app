// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class testttttt extends StatefulWidget {
//   @override
//   _testtttttState createState() => _testtttttState();
// }
//
// class _testtttttState extends State<testttttt> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _dateOfBirthController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   Future<void> _register() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         final response = await http.post(
//           Uri.parse('https://51.20.185.91/api/v1/auth/register'),
//           headers: {'Content-Type': 'application/json'},
//           body: json.encode({
//             "name": _nameController.text,
//             "email": _emailController.text,
//             "phone": _phoneController.text,
//             "password": _passwordController.text,
//             "dateOfBirth": _dateOfBirthController.text,
//             "age": 0, // Adjust as necessary
//           }),
//         );
//
//         // Print the response status and body for debugging
//         print('Response status: ${response.statusCode}');
//         print('Response body: ${response.body}');
//
//         if (response.statusCode == 201) {
//           final data = json.decode(response.body);
//           final token = data['token'];
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registered successfully! Token: $token')));
//         } else {
//           // Handle non-200 responses
//           // String errorMessage;
//           try {
//             final errorData = json.decode(response.body);
//             errorMessage = errorData['message'] ?? 'An error occurred';
//           } catch (e) {
//             errorMessage = 'Unexpected error: ${response.body}';
//           }
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $errorMessage')));
//         }
//       } catch (e) {
//         print('Error: $e');
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(15.r),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 10.h),
//                   Text(
//                     'إنشاء حساب',
//                     style: TextStyle(fontSize: 32, color: Colors.black),
//                   ),
//                   const Text(
//                     'أدخل بياناتك الشخصية',
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
//                   ),
//                   SizedBox(height: 20.h),
//                   // Full name field
//                   TextFormField(
//                     controller: _nameController,
//                     decoration: InputDecoration(hintText: 'الاسم بالكامل'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'الرجاء ادخال الاسم بالكامل';
//                       }
//                       return null;
//                     },
//                   ),
//                   // Email field
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: InputDecoration(hintText: 'الحساب الاكتروني'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'الرجاء ادخال الحساب الالكتروني';
//                       }
//                       return null;
//                     },
//                   ),
//                   // Phone field
//                   TextFormField(
//                     controller: _phoneController,
//                     decoration: InputDecoration(hintText: 'رقم الهاتف'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'الرجاء ادخال رقم الهاتف';
//                       }
//                       return null;
//                     },
//                   ),
//                   // Password field
//                   TextFormField(
//                     controller: _passwordController,
//                     decoration: InputDecoration(hintText: 'كلمة المرور'),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'الرجاء ادخال كلمة المرور';
//                       }
//                       return null;
//                     },
//                   ),
//                   // Date of birth field
//                   TextFormField(
//                     controller: _dateOfBirthController,
//                     decoration: InputDecoration(hintText: 'تاريخ الميلاد'),
//                     readOnly: true,
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(1900),
//                         lastDate: DateTime.now(),
//                       );
//                       if (pickedDate != null) {
//                         _dateOfBirthController.text = pickedDate.toIso8601String();
//                       }
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'الرجاء ادخال تاريخ الميلاد';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 28.h),
//                   // Create account button
//                   ElevatedButton(
//                     onPressed: _register,
//                     child: Text('إنشاء حساب'),
//                   ),
//                   SizedBox(height: 20.h),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }