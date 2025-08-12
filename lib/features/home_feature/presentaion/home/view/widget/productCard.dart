import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/images/app_images.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/theme/style.dart';
import '../../../../../fav_feature/presentation/bloc/fav_cubit.dart';
import '../../../../../fav_feature/presentation/bloc/fav_state.dart';
import '../ProductDetailsScreen.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String brandName;
  final double price;
  final double oldPrice;
  final double salePercentage;
  final String imageUrl;
  final String description;
  final int productId;

  const ProductCard({
    Key? key,
    required this.productName,
    required this.brandName,
    required this.price,
    required this.oldPrice,
    required this.salePercentage,
    required this.imageUrl,
    required this.description,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedPrice =
        NumberFormat.currency(symbol: '', decimalDigits: 0).format(price);

    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        bool isFavorite = false;
        if (state is FavoriteLoaded) {
          isFavorite = state.favorites.any((fav) => fav.id == productId);
        }

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProductDetailsScreen(
                  productName: productName,
                  brand: brandName,
                  oldPrice: oldPrice,
                  newPrice: price,
                  discountPercentage: salePercentage,
                  images: [
                    AppImages.pS,
                    AppImages.pS,
                    AppImages.pS,
                    AppImages.pS
                  ],
                  description: description,
                  productId: productId,
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 5.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 6.r,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  height: 130.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r),
                    ),
                    image: DecorationImage(
                      image: AssetImage(AppImages.test),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      if (salePercentage > 0)
                        Positioned(
                          top: 8.h,
                          right: 8.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 4.h,
                              horizontal: 8.w,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.SecondaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              '-${salePercentage.toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.SecondaryColor,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        top: 1.h,
                        left: 4.w,
                        child: FavoriteIcon(
                          productId: productId,
                        ),
                      ),
                    ],
                  ),
                ),
                // Product Details
                Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brandName,
                        style: AppStyle.textStyle12.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        productName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.textStyle16.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Text(
                            formattedPrice,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.MainColor,
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            'د.ل',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          if (salePercentage > 0)
                            Row(
                              children: [
                                Text(
                                  oldPrice.toStringAsFixed(0),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black54,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.black54,
                                  ),
                                ),
                                Text(
                                  'د.ل',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black54,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FavoriteIcon extends StatelessWidget {
  final int productId;

  const FavoriteIcon({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        bool isFavorite = context.read<FavoriteCubit>().isFavorite(productId);

        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            if (isFavorite) {
              context.read<FavoriteCubit>().removeFavorite(productId);
            } else {
              context.read<FavoriteCubit>().addFavorite(productId);
            }
          },
        );
      },
    );
  }
}
