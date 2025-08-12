import 'package:arkanstore_app/core/Routing/routes.dart';
import 'package:arkanstore_app/core/images/app_images.dart';
import 'package:arkanstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(AppImages.arkanLogo, height: 40.h),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            _buildCartItem(
              image: AppImages.test,
              name: 'Huawei Matebook X13',
              oldPrice: '163.0',
              price: '148.0',
              size: 'XS',
            ),
            SizedBox(height: 12.h),
            _buildCartItem(
              image: AppImages.arkanLogo,
              name: 'Alexa Home',
              oldPrice: '158.0',
              price: '137.0',
              size: 'XS',
            ),
            SizedBox(height: 12.h),

            _buildCartItem(
              image: AppImages.arkanLogo,
              name: 'Alexa Home',
              oldPrice: '158.0',
              price: '137.0',
              size: 'XS',
            ),
            SizedBox(height: 12.h),

            _buildCartItem(
              image: AppImages.arkanLogo,
              name: 'Alexa Home',
              oldPrice: '158.0',
              price: '137.0',
              size: 'XS',
            ),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.staticCheckoutScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.SecondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'استمرار',
                  style: TextStyle(fontSize: 16.sp , color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem({
    required String image,
    required String name,
    required String oldPrice,
    required String price,
    required String size,
  }) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(image, width: 70.w, height: 70.h, fit: BoxFit.cover),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, textAlign: TextAlign.right),
                SizedBox(height: 4.h),
                Text('الحجم: $size', style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
                SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Text(
                      '$oldPrice د.ل',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Text('$price د.ل', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),

          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  // handle delete
                },
                child: Icon(Icons.delete_outline, color: Colors.grey),
              ),
              SizedBox(height: 8), // spacing between trash and counter
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      // handle decrease
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: const Icon(Icons.remove, size: 16),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    '1', // quantity value
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      // handle increase
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: const Icon(Icons.add, size: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),


        ],
      ),
    );
  }
}


class StaticCheckoutScreen extends StatelessWidget {
  const StaticCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Image.asset(AppImages.arkanLogo, height: 40.h),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 20.h),
              _buildSectionTitle('عنوان التوصيل'),
              _buildDropdownTile('طرابلس'),
              _buildMapTile('الموقع على الخريطة', 'حدد مكان التسليم'),
              SizedBox(height: 12.h),
              _buildSectionTitle('طريقة الدفع'),
              _buildDropdownTile('اختر وسيلة الدفع'),
              SizedBox(height: 16.h),
              _buildSectionTitle('الملخص'),
              _buildSummaryBox(),
              SizedBox(height: 12.h),
              Text(
                'سيتم توصيل الطلب خلال 12-18 يوم في الظروف الطبيعية',
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.SecondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'التأكيد والدفع',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        title,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildDropdownTile(String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.keyboard_arrow_down),
          Text(
            text,
            style: TextStyle(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildMapTile(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12.h, bottom: 6.h),
          child: Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            subtitle,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryBox() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildSummaryRow('تكلفة الطلبية', '285.0 د.ل'),
          _buildSummaryRow('تكلفة التوصيل', '15.0 د.ل'),
          Divider(thickness: 1, color: Colors.grey.shade300),
          _buildSummaryRow('الإجمالي', '300.0 د.ل', isBold: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

