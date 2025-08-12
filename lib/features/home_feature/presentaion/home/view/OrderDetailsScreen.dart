import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/theme/colors.dart';

class OrderDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> orderDetails = {
      'orderNumber': '#985',
      'status': 'تحت الاجراء',
      'date': '25-08-2024',
      'address': 'طرابلس، ليبيا',
      'phone': '+218 91 1234567',
      'paymentMethod': 'الدفع عند الاستلام',
      'deliveryCost': 10.00,
      'products': [
        {
          'name': 'سماعة رأس',
          'quantity': 2,
          'price': 100.00,
          'image': AppImages.test,
        },
        {
          'name': 'لوحة مفاتيح',
          'quantity': 1,
          'price': 150.00,
          'image': AppImages.test,
        },
      ],
    };

    double subtotal = orderDetails['products']
        .fold(0, (sum, product) => sum + product['price'] * product['quantity']);
    double grandTotal = subtotal + orderDetails['deliveryCost'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'تفاصيل الطلب',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.MainColor,
          ),
        ),
        // iconTheme: IconThemeData(color: AppColors.SecondaryColor),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderHeader(orderDetails),
            SizedBox(height: 20.h),
            _buildOrderDetailsSection(orderDetails),
            SizedBox(height: 20.h),
            _buildOrderSummarySection(subtotal, grandTotal, orderDetails),
            SizedBox(height: 20.h),
            _buildProductList(orderDetails['products']),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHeader(Map<String, dynamic> orderDetails) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'رقم الطلب: ',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.MainColor,
                ),
              ),
              Text(
                '${orderDetails['orderNumber']}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.SecondaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: AppColors.SecondaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              orderDetails['status'],
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.SecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetailsSection(Map<String, dynamic> orderDetails) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderDetailRow( 'تاريخ الطلب', orderDetails['date']),
          SizedBox(height: 10.h),
          _buildOrderDetailRow( 'العنوان', orderDetails['address']),
          SizedBox(height: 10.h),
          _buildOrderDetailRow( 'رقم الهاتف', orderDetails['phone']),
          SizedBox(height: 10.h),
          _buildOrderDetailRow( 'طريقة الدفع', orderDetails['paymentMethod']),
        ],
      ),
    );
  }

  Widget _buildOrderSummarySection(double subtotal, double grandTotal, Map<String, dynamic> orderDetails) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderSummaryRow('التكلفة الفرعية:', 'LYD $subtotal'),
          SizedBox(height: 10.h),
          _buildOrderSummaryRow('تكلفة التوصيل:', 'LYD ${orderDetails['deliveryCost']}'),
          Divider(color: Colors.grey[400]),
          _buildOrderSummaryRow('الإجمالي:', 'LYD $grandTotal', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildProductList(List<Map<String, dynamic>> products) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'المنتجات',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.MainColor,
            ),
          ),
          SizedBox(height: 10.h),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: products.length,
            separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildProductListItem(product);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetailRow( String label, String detail) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.MainColor,
          ),
        ),
        SizedBox(width: 5,),
        Expanded(
          child: Text(
            detail,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: isTotal ? AppColors.MainColor : Colors.grey[800],
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: isTotal ? AppColors.SecondaryColor : Colors.grey[800],
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildProductListItem(Map<String, dynamic> product) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            image: DecorationImage(
              image: AssetImage(product['image']),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product['name'],
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5.h),
              Text(
                'الكمية: ${product['quantity']}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                'LYD ${product['price']}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.SecondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
