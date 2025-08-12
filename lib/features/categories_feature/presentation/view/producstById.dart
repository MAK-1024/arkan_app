import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/images/app_images.dart';
import '../../../../core/theme/colors.dart';
import '../../../home_feature/presentaion/home/view/widget/productCard.dart';
import '../bloc/product/product_cubit.dart';
import '../bloc/product/product_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsScreen extends StatelessWidget {
  final int categoryId;
  final String categoryName;

  const ProductsScreen({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  void _setupScrollListener(
      BuildContext context, ScrollController scrollController) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<ProductCubit>().fetchMoreProductsByCategory(categoryId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    // Trigger fetching initial products when the screen is built
    context.read<ProductCubit>().fetchProductsByCategory(categoryId);
    _setupScrollListener(context, _scrollController);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.appBarColor,
            floating: true,
            snap: false,
            pinned: true,
            title: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'إبحث . . .',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                    onChanged: (value) {
                      // Implement search functionality
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    // Implement filter functionality
                  },
                ),
              ],
            ),
          ),
          BlocConsumer<ProductCubit, ProductState>(
            listener: (context, state) {
              if (state is ProductError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              if (state is ProductLoading) {
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.55,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Skeletonizer(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                        );
                      },
                      childCount: 6, // Placeholder count while loading
                    ),
                  ),
                );
              } else if (state is ProductLoaded ||
                  state is ProductLoadingMore) {
                final products = state is ProductLoaded
                    ? state.products
                    : (state as ProductLoadingMore).products;
                final hasMore = state is ProductLoaded
                    ? state.hasMore
                    : (state as ProductLoadingMore).hasMore;

                if (products.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'لا يوجد منتجات حاليا',
                        style: TextStyle(
                          color: AppColors.MainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index < products.length) {
                          final product = products[index];
                          final oldPrice = product.price;
                          final discount = product.discount;
                          final newPrice =
                              oldPrice! - (oldPrice! * (discount! / 100));

                          return ProductCard(
                            imageUrl: AppImages.mSI,
                            productName: product.name!,
                            oldPrice: oldPrice,
                            salePercentage: discount,
                            price: newPrice,
                            brandName: 'lenovo',
                            description: product.description!,
                            productId: product.id,
                          );
                        } else {
                          // Show loading spinner for more data fetching
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LoadingAnimationWidget.twoRotatingArc(
                                size: 40,
                                color: AppColors.SecondaryColor,
                              ),
                            ],
                          );
                        }
                      },
                      childCount:
                          hasMore ? products.length + 1 : products.length,
                    ),
                  ),
                );
              } else if (state is ProductError) {
                return SliverFillRemaining(
                  child: Center(child: Text(state.message)),
                );
              } else {
                return SliverFillRemaining(
                  child: Center(child: Text("لا يوجد منتجات حاليا")),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
