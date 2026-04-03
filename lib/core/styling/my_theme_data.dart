import 'package:flutter/material.dart';
import 'package:hungry/core/styling/app_colors.dart';
import 'package:hungry/core/styling/app_fonts.dart';
import 'package:hungry/core/styling/app_styles.dart';

class MyThemeData {
  static  final ThemeData lightMode =ThemeData(
    primaryColor: AppColors.primaryColor,
    fontFamily: AppFonts.mainFont,

    bottomNavigationBarTheme:BottomNavigationBarThemeData(
    selectedItemColor: AppColors.whiteColor,
    unselectedItemColor: AppColors.grayColor,
    showUnselectedLabels: false,
    elevation: 0,
    backgroundColor: Colors.transparent
  ) ,

    textTheme: TextTheme(
      titleLarge: AppStyles.mainBlackTextStyle,
      titleMedium: AppStyles.secBlackTextStyle,
      titleSmall: AppStyles.thirdBlackTextStyle,
      bodyLarge: AppStyles.mainBlackTextStyle,
      bodyMedium: AppStyles.secBlackTextStyle,
      bodySmall: AppStyles.thirdBlackTextStyle
    ),
    
  ) ;
}