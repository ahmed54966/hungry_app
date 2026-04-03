import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/styling/app_colors.dart';
import 'package:hungry/core/widgets/custom_elvated_button.dart';



// ignore: must_be_immutable
class CardItem extends StatelessWidget {

  String title;
  int price;
  String image;
  int quntity;
  CardItem({super.key, required this.image,
  required this.price,required this.title,
  required this.quntity});
  
  @override
  Widget build(BuildContext context) {
    return Card(
              elevation: 5.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(image,width: 150,),
                            
                          ],
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Text(title,style: Theme.of(context).textTheme.bodyMedium,),
                              Text("price: $price",style: Theme.of(context).textTheme.bodySmall,),
                              Text("Quntity: $quntity",style: Theme.of(context).textTheme.bodySmall,)
                            ],
                          ),
                        ),
                      
                      ],
                    ),
                  ),
                  Gap(10),
                        CustomElvatedButton(backGroundColor: AppColors.primaryColor, 
                        forGroundColor: AppColors.primaryColor, 
                        borderRadius: 10, 
                        paddingHorizontal: 20, 
                        paddingVertical: 15, 
                        text: "Reorder", 
                        textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.whiteColor),
                        borderColor: AppColors.redColor,),
                ],
              ),
            );
    
  }
}