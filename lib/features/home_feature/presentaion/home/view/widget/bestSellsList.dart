import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:arkanstore_app/features/home_feature/presentaion/home/view/widget/productCard.dart';

class BestSellsList extends StatelessWidget {
  const BestSellsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int oldPrice = 500;
    final double salePercentage = 50;

    final newPrice = oldPrice - (oldPrice * (salePercentage / 100));


    return SizedBox(
      height: 270.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 180.w,
            child: ProductCard(
              productName: 'ماوس قيمنق',
              brandName: 'lenovo',
              price: newPrice * (index + 1),
              oldPrice: oldPrice * (index + 1),
              salePercentage: salePercentage,
              imageUrl: 'assets/images/product_.jpg',
               description: '0000000000', productId: 0,
            ),
          );
        },
      ),
    );
  }
}