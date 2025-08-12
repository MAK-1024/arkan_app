import 'package:arkanstore_app/features/home_feature/presentaion/home/view/widget/SectionTitle.dart';
import 'package:arkanstore_app/features/home_feature/presentaion/home/view/widget/bestSellsList.dart';
import 'package:arkanstore_app/features/home_feature/presentaion/home/view/widget/brandlist_widget.dart';
import 'package:arkanstore_app/features/categories_feature/presentation/view/categoryItem_list.dart';
import 'package:arkanstore_app/features/home_feature/presentaion/home/view/widget/customHomeAppBar.dart';
import 'package:arkanstore_app/features/banner_feature/presentation/view/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {

    String customerName = "مختار";

    return Scaffold(
      backgroundColor: Colors.white60,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 1,
            title: CustomHomeAppBar(),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'مرحبا $customerName',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'نحن سعداء بزيارتك لمتجرنا!',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

              ],

            ),
          ),
          // Carousel slider
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: SizedBox(
                width: double.infinity,
                child: ImageSlider(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h),

            SectionTitle(
                  title: 'الأقسام',
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                SizedBox(height: 10.h),
                CategoryList(),
                SizedBox(height: 10.h),
                // Divider(),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildSection('العلامات التجارية 🏷️', BrandList()),
                _buildSection('أفضل الصفقات 🔥', BestSellsList()),
                _buildSection('موصى به لك 💯', BestSellsList()),
                _buildSection('أكبر التخفيضات', BestSellsList()),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: title, navigationText: 'المزيد'),
          SizedBox(height: 12.h),
          child,
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
