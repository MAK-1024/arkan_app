import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/style.dart';
import '../../../features/home_feature/presentaion/home/view/widget/customHomeAppBar.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Increased padding
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              // CustomHomeAppBar(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100], // Lighter background
                  borderRadius: BorderRadius.circular(25), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'إبحث عن منتجاتك . . .  ',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18), // Increased padding
                  ),
                  onChanged: (value) {
          // Handle search logic here
                  },
                ),
              ),
              SizedBox(height: 48.h), // Increased spacing
          // Placeholder Illustration
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 150.sp, // Reduced icon size
                      color: Colors.grey[300], // Lighter icon color
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'على ماذا تبحث ؟',
                      style: AppStyle.textStyle20.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'ابدأ بكتابة ما تبحث عنه في شريط البحث أعلاه',
                      textAlign: TextAlign.center,
                      style: AppStyle.textStyle16.copyWith(
                        color: Colors.grey[600],)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
