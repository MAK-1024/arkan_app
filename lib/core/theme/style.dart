import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

abstract class AppStyle {
  static TextStyle textStyle12 = TextStyle(
    color: Colors.grey,
    fontSize: 12.sp,
  );
  static TextStyle textStyle_14 = TextStyle(
    color: AppColors.MainColor,
    fontSize: 16.sp,
  );
  static TextStyle textStyle14 = TextStyle(
      color: AppColors.MainColor,
      fontSize: 16.sp,
      decoration: TextDecoration.underline);
  static TextStyle textStyle16 = TextStyle(
    color: AppColors.MainColor,
    fontSize: 14.sp,
  );
  static TextStyle textStyle18 = TextStyle(
    color: AppColors.MainColor,
    fontSize: 18.sp,
  );
  static TextStyle textStyle24 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle textStyle32 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 32.sp,
  );
  static TextStyle textStyle48 = TextStyle(
    color: Colors.white,
    fontSize: 48.sp,
    fontWeight: FontWeight.bold,
    fontFamily: "Cairo",
  );
  static TextStyle textStyle20 = TextStyle(
    color: AppColors.MainColor,
    fontSize: 20.sp,
  );
}

const TextStyle textStyle = TextStyle();
