import 'package:arkanstore_app/core/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandList extends StatelessWidget {
  final List<String> brandImages = [
    AppImages.mSI,
    AppImages.pS,
    AppImages.lenovo,
    AppImages.xbox,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        itemCount: brandImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Container(
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1.5.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                  child: Image.asset(
                    brandImages[index],
                    fit: BoxFit.contain,
                    height: 40.h,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
