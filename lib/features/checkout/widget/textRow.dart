// ignore: file_names
import 'package:flutter/material.dart';
import 'package:hungry/core/styling/app_colors.dart';

// ignore: must_be_immutable
class Textrow extends StatelessWidget {
    String order ;
    String taxis  ;
    String Delivery_fees;
    String total = "20" ;
  Textrow({super.key, required this.order, required this.Delivery_fees,required this.taxis });
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                  children: [
                    Text("Order",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grayColor),),
                    Text(order,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grayColor))
                ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                  children: [
                    Text("Taxes",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grayColor),),
                    Text(taxis,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grayColor))
                ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                  children: [
                    Text("Delivery fees",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grayColor),),
                    Text(Delivery_fees,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grayColor))
                ],
                ),
              ),
              Divider(thickness: 2,),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                  children: [
                    Text("Total",style: Theme.of(context).textTheme.bodyMedium),
                    Text("${int.parse(order) + int.parse(taxis)+int.parse(Delivery_fees)} EGP",style: Theme.of(context).textTheme.bodyMedium)
                ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                  children: [
                    Text("Estimated delivery time:",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 10)),
                    Text("15 - 20 mins",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 10))
                ],
                ),
              ),
      ],
    );
  }
}