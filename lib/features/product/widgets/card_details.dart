import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/styling/app_colors.dart';

class CardDetails extends StatefulWidget {
  final String image;
  final String text;
  final int id; 
  final ValueChanged<bool> onChanged;

  const CardDetails({
    super.key,
    required this.image,
    required this.text,
    required this.id,
    required this.onChanged,
  });

  @override
  State<CardDetails> createState() => _CardDetailsState();
  
}


class _CardDetailsState extends State<CardDetails> {

  
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.onChanged(isSelected);
        });
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: const Color(0xFF2D2626),
          borderRadius: BorderRadius.circular(20),
        
          boxShadow: [
            BoxShadow(
              color: isSelected ? Colors.green : AppColors.blackColor,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 80,
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.network(
                  widget.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const Gap(4),
                  
                  
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300), 
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      
                      color: isSelected ? Colors.green : AppColors.redColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      
                      isSelected ? Icons.check : Icons.add,
                      color: AppColors.whiteColor,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}