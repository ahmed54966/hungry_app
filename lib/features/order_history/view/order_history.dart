import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/styling/app_assets.dart';
import 'package:hungry/features/order_history/widget/card.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Gap(40),
              Column(
                children: List.generate(7, (index){
                  return CardItem(image: AppAssets.bergar,
                  title: "Cheese Bergar",
                  price: 20,
                  quntity: 3,);
              }),
              ),
              Gap(30),

                    
            ]
              
              
              
            
          ),
        ),
      )
      
      
    );
  }
}