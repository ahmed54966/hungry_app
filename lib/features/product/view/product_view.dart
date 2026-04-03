import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/styling/app_colors.dart';
import 'package:hungry/core/widgets/custom_elvated_button.dart';
import 'package:hungry/core/widgets/dialog_utilies.dart';
import 'package:hungry/features/home/data/model/side_options_model.dart';
import 'package:hungry/features/home/data/model/topping_model.dart';
import 'package:hungry/features/home/data/repo/product_repo.dart';
import 'package:hungry/features/product/data/cart_model.dart';
import 'package:hungry/features/product/data/cart_repo.dart';
import 'package:hungry/features/product/widgets/card_details.dart';
import 'package:hungry/network/api_error.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class ProductView extends StatefulWidget {
final String imageUrl;
final int productId;
final int productPrice;
  const ProductView({super.key, required this.imageUrl,required this.productId,required this.productPrice});
  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  List<int> selectedToppings = [];
  List<int> selectedSideOptions = [];
  double value = 0.5;
  ProductRepo productRepo = ProductRepo();
  List<ToppingModel>? toppings;
  List<SideOptionsData>? sideOptionsData;
  CartRepo cartRepo = CartRepo();

  Future<void> getToppingData() async {
    try {
      final res = await productRepo.getToppingData();
      if (!mounted) return;
      setState(() {
        toppings = res ;
      });

      
    
    } catch (e) {
      if (!context.mounted) return;

    
      String displayMessage = "Something went wrong";
      if (e is ApiError) {
        displayMessage = e.message;
      } else {
        displayMessage = e.toString();
      }

      DialogUtiles.showMessage(
        context: context,
        message: displayMessage, 
        title: "Error",
        posActionName: "ok",
      );
    
  }
}

Future<void> getSideOptionsData() async {
    try {
      final res = await productRepo.getSideOptionsData();
      if (!mounted) return;
      setState(() {
        sideOptionsData = res ;
      });

      
    
    } catch (e) {
      if (!context.mounted) return;

    
      String displayMessage = "Something went wrong";
      if (e is ApiError) {
        displayMessage = e.message;
      } else {
        displayMessage = e.toString();
      }

      DialogUtiles.showMessage(
        context: context,
        message: displayMessage, 
        title: "Error",
        posActionName: "ok",
      );
    
  }
}

@override
  void initState() {
    getToppingData();
    getSideOptionsData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back)),
      ),
      body: Skeletonizer(
        enabled: sideOptionsData == null && toppings == null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
  crossAxisAlignment: CrossAxisAlignment.start, 
  children: [
    
    SizedBox(
      width: 120, 
      height: 120,
      child: ClipRRect( 
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          widget.imageUrl,
          fit: BoxFit.cover, 
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, size: 50); 
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    ),
    const Gap(10),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Text(
            "Customize Your Burger\nto Your Tastes.\nUltimate Experience",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Slider(
            value: value,
            activeColor: AppColors.primaryColor,
            onChanged: (v) {
              setState(() {
                value = v;
              });
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("❄️"),
                Text("🔥"),
              ],
            ),
          ),
        ],
      ),
    ),
  ],
),
                Gap(20),
            
                Align(alignment: AlignmentGeometry.centerLeft,
                  child: Text("Toppings",style: Theme.of(context).textTheme.bodyLarge,)),
                  Gap(20),
            
                  SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: 
                            List.generate(toppings?.length?? 0, (index){
                              final topping = toppings?[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CardDetails(
                                  image: topping?.image??"", 
                                  text: topping?.name??"",
                                  onChanged: (isSelected) {
                                if (isSelected) {
                                  selectedToppings.add(topping?.id??0);
                                } else {
                                  selectedToppings.remove(topping?.id??0);
                                }
                              }, 
                              id: topping?.id ?? 0,),
                              );
                            })
                          
                        ),
                      ),
                      Gap(20),
            
                      Align(alignment: AlignmentGeometry.centerLeft,
                  child: Text("Side OPtions",style: Theme.of(context).textTheme.bodyLarge,)),
            
                      Gap(20),
            
                  SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: 
                            List.generate(sideOptionsData?.length??0, (index){
                              final sideOptionData = sideOptionsData?[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CardDetails(
                                  image:sideOptionData?.image??"", 
                                text: sideOptionData?.name??"",
                                onChanged: (isSelected) {
                                  if (isSelected) {
                                    selectedSideOptions.add(sideOptionData?.id??0);
                                  } else {
                                    selectedSideOptions.remove(sideOptionData?.id??0);
                                  }
                                }, id: sideOptionData?.id ?? 0,
                                ),
                              );
                            })
                          
                        ),
                      ),
        
                      Gap(130),
        
                      
            
                  
            
            
            
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
                    height: 120,
                    color: Colors.blueGrey[50],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Column(
                          children: [
                            Text("Total",style: Theme.of(context).textTheme.bodyLarge,),
                            Text(widget.productPrice.toString(),style: Theme.of(context).textTheme.bodyLarge,)
                          ],
                        ),
                        CustomElvatedButton(backGroundColor: AppColors.primaryColor, 
                        forGroundColor: AppColors.primaryColor, 
                        borderRadius: 15, 
                        paddingHorizontal: 30, 
                        paddingVertical: 15, 
                        text: "Add to Card", 
                        fun: () async {
    
                                DialogUtiles.ShowLoading(context: context, message: "Adding to cart...");

                                try {
                                  final cartItem = CartModel(
                                    productId: widget.productId,
                                    quantity: 1,
                                    spicy: value,
                                    sideOptions: selectedSideOptions,
                                    toppings: selectedToppings,
                                  );

                                  
                                  await cartRepo.addToCart(CartRequestModel(items: [cartItem]));

                                  
                                  if (!context.mounted) return;
                                  DialogUtiles.hideDialog(context);

                                  
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Added Successfully! ✅"), backgroundColor: Colors.green),
                                  );
                                  
                                  context.pop(); 

                                } catch (e) {
                                  
                                  if (!context.mounted) return;
                                  DialogUtiles.hideDialog(context);
                                  
                                  DialogUtiles.showMessage(
                                    context: context,
                                    message: e is ApiError ? e.message : "Failed to add item",
                                    title: "Error",
                                    posActionName: "Try Again",
                                  );
                                }
                              },
                        textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.whiteColor),
                        borderColor: AppColors.redColor,),
                      ],),
                    ),
                    )
    );
  }
}