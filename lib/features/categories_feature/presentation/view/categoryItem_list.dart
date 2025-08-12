import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/images/app_images.dart';
import '../../../../core/theme/colors.dart';
import 'package:arkanstore_app/features/categories_feature/presentation/view/producstById.dart';

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

class CategoryList extends StatelessWidget {
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 140.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          itemCount: mockCategories.length,
          itemBuilder: (context, index) {
            final category = mockCategories[index];
            return _buildCategoryItem(context, category);
          },
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, CategoryModel category) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductsScreen(
              categoryId: category.id,
              categoryName: category.name,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Container(
          width: 100.w,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1.5.w,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 12.h),
              SizedBox(
                width: 60.w,
                height: 60.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    category.imageAsset,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
