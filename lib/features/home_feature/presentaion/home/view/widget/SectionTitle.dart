import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/theme/colors.dart';
class SectionTitle extends StatelessWidget {
  final String title;
  final String? navigationText;
  final String? route;
  final MainAxisAlignment mainAxisAlignment;


  const SectionTitle({
    Key? key,
    required this.title,
    this.navigationText,
    this.route,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: () {
              GoRouter.of(context)
                  .push(route!);
            },
            child: Row(
              children: [
                Text(
                  navigationText ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.moreColor,
                  ),
                ),
                SizedBox(width: 8.w),
                // Icon(Icons.arrow_circle_left_outlined, color: AppColors.moreColor), // Optional icon
              ],
            ),
          ),
        ],
      ),
    );
  }
}
