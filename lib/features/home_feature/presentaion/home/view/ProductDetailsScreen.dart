import 'package:arkanstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productName;
  final String brand;
  final double oldPrice;
  final double newPrice;
  final double discountPercentage;
  final List<String> images;
  final String description;
  final int productId;

  final ValueNotifier<int> quantityNotifier = ValueNotifier<int>(1);
  final ValueNotifier<int> currentImageIndexNotifier = ValueNotifier<int>(0);

  ProductDetailsScreen({
    Key? key,
    required this.productName,
    required this.brand,
    required this.oldPrice,
    required this.newPrice,
    required this.discountPercentage,
    required this.images,
    required this.description,
    required this.productId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImageGallery(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: AppColors.MainColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                  color: AppColors.MainColor.withOpacity(0.5),
                                  width: 1),
                            ),
                            child: Text(
                              '$brand',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.MainColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'الوصف',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  description,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    height: 1.7,
                                    color: Colors.black87,
                                    letterSpacing: 0.6,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, -1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (discountPercentage > 0)
                        Padding(
                          padding: EdgeInsets.only(left: 30.w),
                          child: Text(
                            '${discountPercentage.toStringAsFixed(0)}% خصم',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          if (discountPercentage > 0)
                            Text(
                              '${oldPrice.toStringAsFixed(0)} د.ل',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.grey,
                              ),
                            ),
                          SizedBox(width: 5.h),
                          ValueListenableBuilder<int>(
                            valueListenable: quantityNotifier,
                            builder: (context, quantity, _) {
                              return Text(
                                ' ${(newPrice * quantity).toStringAsFixed(0)} د.ل',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.MainColor,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 12.h, horizontal: 15),
                      backgroundColor: AppColors.MainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'أضف إلى السلة',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGallery() {
    return Column(
      children: [
        Text(
          productName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5.h),
        Container(
          height: 300.h,
          child: PageView.builder(
            itemCount: images.length,
            onPageChanged: (index) {
              currentImageIndexNotifier.value = index;
            },
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
        ValueListenableBuilder<int>(
          valueListenable: currentImageIndexNotifier,
          builder: (context, currentIndex, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: currentIndex == index ? 12.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index
                        ? AppColors.MainColor
                        : Colors.grey,
                  ),
                );
              }),
            );
          },
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
