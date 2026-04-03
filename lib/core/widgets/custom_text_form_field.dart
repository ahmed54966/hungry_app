import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/styling/app_colors.dart';


// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  String? labelTextName;
  String? hintText;
  String? Function(String?) validator;
  TextInputType keyboardType;
  TextEditingController controller;
  final Widget? suffixIcon;
  final bool showPassword;
  CustomTextFormField({super.key,  this.labelTextName,
  required this.validator,
  required this.controller,
  this.keyboardType = TextInputType.text,
  this.showPassword = false,
  this.suffixIcon,
  this.hintText
  });
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
                  style: TextStyle(color: AppColors.blackColor,
                  fontSize: 14.sp),
                  
                  decoration: InputDecoration(
                    suffixIcon:suffixIcon,
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2,
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2, ),
                    ),
                    errorBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: AppColors.redColor,
                        width: 2, ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: AppColors.redColor,
                        width: 2, ),
                        ),
                    hintText: hintText,
                    hintStyle: TextStyle(
                    color: AppColors.grayColor, 
                    fontSize: 10,                        
                    fontWeight: FontWeight.w400,          
                      ),
                    labelText: labelTextName,
                    labelStyle: Theme.of(context).textTheme.titleMedium
                  ),
                  validator:validator,
                  keyboardType: keyboardType,
                  controller:controller ,
                  obscureText: showPassword,
                  
                ),
    );
  }
}
