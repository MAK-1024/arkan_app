import 'package:arkanstore_app/core/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart'; // Import skeletonizer

import '../../../../core/Routing/routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/style.dart';
import '../../../categories_feature/domain/entity/product_entity.dart';
import '../../../home_feature/presentaion/home/view/ProductDetailsScreen.dart';
import '../bloc/fav_cubit.dart';
import '../bloc/fav_state.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<FavoriteCubit>().getFavorites();

    return Scaffold(
      appBar: AppBar(
        title: Text('المفضلة'),
      ),
      body: BlocConsumer<FavoriteCubit, FavoriteState>(
        listener: (context, state) {
          if (state is FavoriteActionSuccess) {
            context.read<FavoriteCubit>().getFavorites();

          }
        },
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return _buildSkeletonLoading();
          } else if (state is FavoriteError) {
            return Center(child: Text(state.message));
          } else if (state is FavoriteLoaded) {
            if (state.favorites.isEmpty) {
              return _buildEmptyState(context);
            } else {
              return _buildProductList(state.favorites);
            }
          }
          return _buildEmptyState(context);
        },
      ),
    );
  }

Widget _buildSkeletonLoading() {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Skeletonizer(
              enabled: true,
              child: _buildSkeletonItem(),
            ),
          );
        },
      ),
    );
  }

  // Skeleton item structure
  Widget _buildSkeletonItem() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6.r,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            color: Colors.grey[300],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16.h,
                    width: 100.w,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 16.h,
                    width: 150.w,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 16.h,
                    width: 80.w,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 140.w,
              color: Colors.grey[400],
            ),
            SizedBox(height: 24.h),
            Text(
              'لا توجد منتجات في المفضلة',
              style: AppStyle.textStyle20.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'ابدأ في إضافة المنتجات التي تحبها',
              textAlign: TextAlign.center,
              style: AppStyle.textStyle16.copyWith(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 32.h),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go(AppRouter.homePageScreen);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                  vertical: 14.h,
                ),
                backgroundColor: AppColors.SecondaryColor.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Text(
                'استكشاف المنتجات',
                style: TextStyle(
                  color: AppColors.SecondaryColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(List<ProductEntity> favoriteProducts) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: _favoriteProductCard(product, context),
          );
        },
      ),
    );
  }
}


Widget _favoriteProductCard (ProductEntity product, BuildContext context){
    double newPrice = product.price! - (product.price! * (product.discount! / 100));
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ProductDetailsScreen(
              productName: product.name!,
              brand: 'lenovo',
              oldPrice: product.price!,
              newPrice: newPrice,
              discountPercentage: product.discount!,
              images: [AppImages.pS, AppImages.pS, AppImages.pS, AppImages.pS],
              description: product.description!,
              productId: product.id,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6.r,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
              child: Image.asset(
                AppImages.mSI,
                width: 100.w,
                height: 100.h,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 12.w),
            // Product Info
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'lenovo',
                          style: AppStyle.textStyle12.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                        IconButton(
                          icon: Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {
                            // Handle removal from favorites
                            context.read<FavoriteCubit>().removeFavorite(product.id);
                            // No need to fetch favorites here, as the listener will handle it
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    // Product Name
                    Text(
                      product.name!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.textStyle16.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(height: 6.h),
                    // Price Information
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // New Price
                            Row(
                              children: [
                                Text(
                                  newPrice.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.MainColor,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Text(
                                  'د.ل',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            if (product.discount! > 0)
                              Row(
                                children: [
                                  Text(
                                    "${(product.price!.toStringAsFixed(0))}",
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
                        // Sale Percentage
                        if (product.discount! > 0)
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 4.h,
                              horizontal: 8.w,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              "${((product.discount!.toStringAsFixed(0)))}% خصم ",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
