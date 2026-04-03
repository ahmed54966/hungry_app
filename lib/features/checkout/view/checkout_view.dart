import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/styling/app_colors.dart';
import 'package:hungry/core/widgets/custom_elvated_button.dart';
import 'package:hungry/features/checkout/widget/payment.dart';
import 'package:hungry/features/checkout/widget/textRow.dart';

class CheckoutView extends StatefulWidget {
  final int orderPrice ;
  
  CheckoutView({required this.orderPrice});
  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  


  @override
  Widget build(BuildContext context) {
  int deliveryFees = 7;
  int taxes = 2;
  int totalAmount = widget.orderPrice + deliveryFees + taxes;
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20), // شكل أرشق
        ),
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order Summary", style: Theme.of(context).textTheme.titleLarge),
              const Gap(20),
              Textrow(order:widget.orderPrice.toString(),Delivery_fees: deliveryFees.toString(),taxis: taxes.toString(),), 
              const Gap(30),
              Text("Payment Methods", style: Theme.of(context).textTheme.titleLarge),
              const Gap(20),

              
              const PaymentSelectionScreen(),
              
              const Gap(10),
              Row(
                children: [
                  SizedBox(
                    height: 24, width: 24,
                    child: Checkbox(
                      value: true,
                      activeColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      onChanged: (v) {},
                    ),
                  ),
                  const Gap(10),
                  Text("Save card details for future payments", 
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              const Gap(130), 
              
              
              
            ],
          ),
        ),
      ),
      bottomSheet: Container(
                    height: 120,
                    color: AppColors.whiteColor,
                    child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Total", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                        Text("$totalAmount EGP", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    CustomElvatedButton(backGroundColor: AppColors.primaryColor, 
                        forGroundColor: AppColors.primaryColor, 
                        borderRadius: 15, 
                        paddingHorizontal: 30, 
                        paddingVertical: 15,
                        fun: () => context.push("/SuccessDialog"), 
                        text: "Pay Now", 
                        textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.whiteColor),
                        borderColor: AppColors.redColor,),
                  ],
                ),
              ),
      )
    );
  }
}