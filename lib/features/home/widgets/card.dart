import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/styling/app_colors.dart';

class CardItem extends StatelessWidget {
  final String title;
  final String text;
  final String image;

  const CardItem({
    super.key, 
    required this.image,
    required this.text,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Gap(10),
            
            Expanded( 
              child: Image.network(
                image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => 
                    const Icon(Icons.fastfood, size: 50, color: AppColors.grayColor),
              ),
            ),
            const Gap(10),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
              maxLines: 1, 
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.grayColor,
                  ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(5),
          ],
        ),
      ),
    );
  }
}
