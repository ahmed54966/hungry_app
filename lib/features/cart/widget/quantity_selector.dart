import 'package:flutter/material.dart';
import 'package:hungry/core/styling/app_colors.dart';

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({super.key});

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        
        _buildActionButton(
          icon: Icons.remove,
          onTap: () {
            if (quantity > 1) setState(() => quantity--);
          },
        ),
        
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            quantity.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.grayColor, 
            ),
          ),
        ),

        
        _buildActionButton(
          icon: Icons.add,
          onTap: () {
            setState(() => quantity++);
          },
        ),
      ],
    );
  }


  Widget _buildActionButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryColor, 
          borderRadius: BorderRadius.circular(10), 
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: AppColors.whiteColor,
          size: 18,
        ),
      ),
    );
  }
}