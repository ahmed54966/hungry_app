import 'package:flutter/material.dart';

class CustomElvatedButton extends StatelessWidget {
  final Color backGroundColor;
  final Color forGroundColor;
  final Color? borderColor; 
  final void Function()? fun;
  final double paddingHorizontal;
  final double paddingVertical;
  final double borderRadius;
  final String text;
  final TextStyle? textStyle;

  const CustomElvatedButton({
    super.key,
    required this.backGroundColor,
    required this.forGroundColor,
    this.borderColor, 
    this.fun,
    required this.borderRadius,
    required this.paddingHorizontal,
    required this.paddingVertical,
    required this.text,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: ElevatedButton(
        onPressed: fun,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal,
            vertical: paddingVertical,
          ),
      
          side: borderColor != null 
              ? BorderSide(color: borderColor!, width: 2) 
              : BorderSide.none, 
        
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: backGroundColor,
          foregroundColor: forGroundColor,
        ),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}