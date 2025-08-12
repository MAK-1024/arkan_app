
import 'package:arkanstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/style.dart';

BottomNavigationBarItem buildBottomNavBarItem({
  required IconData icon,
  required IconData icon2,
  required String title,
  required int currentIndex,
  required int index,
}) {
  final bool isSelected = currentIndex == index;

  return BottomNavigationBarItem(
    icon: isSelected
        ? Padding(
            padding: currentIndex == 0
                ? const EdgeInsets.only(right: 1)
                : currentIndex == 3
                    ? const EdgeInsets.only(left: 10)
                    : const EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.only(right: 1),
              height: 32.h,
              width: 82.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffE5E5FC),
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected ? icon2 : icon,
                    color: isSelected ? AppColors.MainColor : Colors.black,
                  ),
                  const SizedBox(width: 1),
                  Text(
                    title,

                    style: AppStyle.textStyle12.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppColors.MainColor : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Icon(icon, color: Colors.black),
    label: '',
  );
}
