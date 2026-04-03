import 'package:flutter/cupertino.dart';
import 'package:hungry/core/styling/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hint,
    this.type,
    this.prefix,
    this.maxLength,
    this.onChange
  });
  final ValueChanged<String>? onChange;
  final TextEditingController? controller;
  final String? hint;
  final TextInputType? type;
  final Widget? prefix;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      style: const TextStyle(color: CupertinoColors.black, fontSize: 16),
      onChanged:onChange,
      controller: controller,
      placeholder: hint,padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      keyboardType: type,
      prefix:Padding(
      padding: const EdgeInsets.only(left: 15, right: 5), 
      child: prefix),
      maxLength: maxLength,
      placeholderStyle: TextStyle(fontSize: 15,color: AppColors.grayColor),
      
    );
  }
}
