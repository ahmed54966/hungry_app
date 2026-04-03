import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/styling/app_colors.dart';
import 'package:hungry/core/widgets/custom_elvated_button.dart';
import 'package:hungry/features/cart/widget/quantity_selector.dart';

// ignore: must_be_immutable
class CardItem extends StatelessWidget {

  String title;
  String text;
  String image;
  void Function()? fun;
  CardItem({required this.image,required this.text,required this.title, this.fun});
  
  @override
  @override
Widget build(BuildContext context) {
  return Card(
    elevation: 3.0,
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              image,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.fastfood, size: 50),
            ),
          ),
          const Gap(12),

          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600),
                ),
                const Gap(4),
                Text(
                  text, 
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 1, 
                  overflow: TextOverflow.ellipsis, 
                ),
                
                
              ],
            ),
          ),

          const Gap(10),

  
          Column(
            children: [
              const QuantitySelector(), 
              const Gap(5),
              CustomElvatedButton(
            backGroundColor: AppColors.primaryColor, 
            forGroundColor: AppColors.primaryColor, 
            borderRadius: 15, 
            paddingHorizontal: 20, 
            paddingVertical: 10, 
            text: "Remove",
            fun:fun ,
            textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.whiteColor),)
            ],
          ),
        ],
      ),
    ),
  );
}
}