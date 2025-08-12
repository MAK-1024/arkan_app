import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/images/app_images.dart';
import '../../../../core/theme/colors.dart';
import '../../data/model/category_model.dart';
class CategoryModel {
  final int id;
  final String name;
  final String imageAsset;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageAsset,
  });
}

class CategoriesScreen extends StatelessWidget {



  final List<CategoryModel> mockCategories = [
    CategoryModel(
      id: 1,
      name: 'لابتوبات',
      imageAsset: AppImages.item3,
    ),
    CategoryModel(
      id: 2,
      name: 'سماعات',
      imageAsset: AppImages.item2,
    ),
    CategoryModel(
      id: 3,
      name: 'اجهز',
      imageAsset: AppImages.item1,
    ),
    CategoryModel(
      id: 1,
      name: 'لابتوبات',
      imageAsset: AppImages.item3,
    ),
    CategoryModel(
      id: 2,
      name: 'سماعات',
      imageAsset: AppImages.item2,
    ),
    CategoryModel(
      id: 3,
      name: 'اجهز',
      imageAsset: AppImages.item1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        centerTitle: true,
        title: Text(
          'الاقسام',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView.separated(
          itemCount: mockCategories.length,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            final category = mockCategories[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1.5.w,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        category.name,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppColors.MainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Container(
                      width: 100.w,
                      height: 80.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.asset(
                          category.imageAsset,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
