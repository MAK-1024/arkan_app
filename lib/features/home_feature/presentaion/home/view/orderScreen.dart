import 'package:arkanstore_app/core/Routing/routes.dart';
import 'package:arkanstore_app/core/images/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:arkanstore_app/core/theme/colors.dart';
import 'package:go_router/go_router.dart';

import 'OrderDetailsScreen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          title: Text(
            'الطلبات',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'تحت الاجراء',
                icon: Icon(Icons.pending_actions, color: AppColors.SecondaryColor),
              ),
              Tab(
                text: 'مكتملة / ملغية',
                icon: Icon(Icons.done_all, color: AppColors.SecondaryColor),
              ),
            ],
            labelStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelColor: Colors.grey[500],
            indicatorColor: AppColors.SecondaryColor,
            indicatorWeight: 3.0,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: AppColors.MainColor,
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList(
              context,
              status: 'تحت الاجراء',
              orders: [
                {
                  'number': '#41',
                  'name': 'جهاز الألعاب',
                  'quantity': 1,
                  'price': 120.00,
                  'date': 'الخميس 1 / 9 / 2024 22:55',
                  'image': AppImages.test
                },
                {
                  'number': '#85',
                  'name': 'سماعة رأس',
                  'quantity': 2,
                  'price': 60.00,
                  'date': 'الخميس 1 / 9 / 2024 22:55',
                  'image': AppImages.test
                },
                {
                  'number': '#98',
                  'name': 'لوحة مفاتيح',
                  'quantity': 1,
                  'price': 45.00,
                  'date': 'الخميس 1 / 9 / 2024 22:55',
                  'image': AppImages.test
                },
              ],
              emptyMessage: 'لا توجد طلبات تحت الاجراء',
            ),
            _buildOrderList(
              context,
              status: 'مكتملة / ملغية',
              orders: [
                {
                  'number': '#11',
                  'name': 'ماوس الألعاب',
                  'quantity': 1,
                  'price': 30.00,
                  'date': 'الخميس 1 / 9 / 2024 22:55',
                  'image': AppImages.test
                },
                {
                  'number': '#89',
                  'name': 'شاشة عرض 4K',
                  'quantity': 1,
                  'price': 300.00,
                  'date': 'الخميس 1 / 9 / 2024 22:55',
                  'image': AppImages.test
                },
              ],
              emptyMessage: 'لا توجد طلبات مكتملة أو ملغية',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(BuildContext context,
      {required String status,
        required List<Map<String, dynamic>> orders,
        required String emptyMessage}) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox,
              size: 100.sp,
              color: Colors.grey[400],
            ),
            SizedBox(height: 20.h),
            Text(
              emptyMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: ListView.separated(
        itemCount: orders.length,
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        itemBuilder: (context, index) {
          final order = orders[index];
          return GestureDetector(
            onTap: () {
              GoRouter.of(context).push(AppRouter.orderDetailsScreen);
            },
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8.r,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order['name'],
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${order['number']}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.SecondaryColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            color: status == 'تحت الاجراء'
                                ? AppColors.MainColor.withOpacity(0.1)
                                : AppColors.SecondaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: status == 'تحت الاجراء'
                                  ? AppColors.MainColor
                                  : AppColors.SecondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order['date'],
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          'LYD ${order['price']}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.SecondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

