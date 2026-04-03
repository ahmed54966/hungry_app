import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/styling/app_colors.dart';

class AppStyles {
  static TextStyle mainBlackTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30.sp,
    color: AppColors.blackColor
  );
  static TextStyle mainprimaryTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30.sp,
    color: AppColors.primaryColor
  );
  static TextStyle mainGrayTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30.sp,
    color: AppColors.grayColor
  );
  static TextStyle secGrayTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: AppColors.grayColor
  );
  static TextStyle secBlackTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: AppColors.blackColor
  );
  static TextStyle thirdGrayTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
    color: AppColors.grayColor
  );
  static TextStyle thirdBlackTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
    color: AppColors.blackColor
  );
}