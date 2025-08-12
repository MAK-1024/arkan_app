import 'package:arkanstore_app/core/Routing/routes.dart';
import 'package:arkanstore_app/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomHomeAppBar extends StatefulWidget {
  @override
  _CustomHomeAppBarState createState() => _CustomHomeAppBarState();
}

class _CustomHomeAppBarState extends State<CustomHomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          'متجر اركان',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.favoriteScreen);
          },
          icon: Icon(
            Icons.favorite_outline,
            size: 26,
            color: AppColors.MainColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.notificationScreen);
            },
            icon: Icon(
              Icons.notifications_active_outlined,
              size: 26,
              color: AppColors.MainColor,
            ),
          ),
        ]);
  }
}
