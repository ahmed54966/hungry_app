import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/routing/routes_generation.dart';
import 'package:hungry/core/styling/my_theme_data.dart';


void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
        routerConfig: RoutesGeneration.goRouter,
        
        debugShowCheckedModeBanner: false,
        theme: MyThemeData.lightMode,
      );
      },
      
    );
  }
}