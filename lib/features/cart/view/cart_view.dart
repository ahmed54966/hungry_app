import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/styling/app_assets.dart';
import 'package:hungry/core/styling/app_colors.dart';
import 'package:hungry/core/widgets/custom_elvated_button.dart';
import 'package:hungry/core/widgets/dialog_utilies.dart';
import 'package:hungry/features/cart/widget/card.dart';
import 'package:hungry/features/cart/data/get_cart_model.dart';
import 'package:hungry/features/cart/data/get_cart_repo.dart';
import 'package:hungry/network/api_error.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  GetCartRepo cartRepo = GetCartRepo();

  
  CartResponseModel? cartData; 

  bool isLoading = true; 
  String? errorMessage;

  Future<void> getcartData() async {
    try {
      setState(() => isLoading = true); 
      
      
      final res = await cartRepo.getCart(); 
      
      if (!mounted) return;
      
      setState(() {
        
        cartData = res; 
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        errorMessage = e is ApiError ? e.message : e.toString();
      });
      
      DialogUtiles.showMessage(context: context, message: errorMessage!, title: "Error");
    }
  }

  Future<void> removeItem(int itemId) async {
  try {
    
    DialogUtiles.ShowLoading(context: context, message: "loading...");
  
    final updatedData = await cartRepo.deleteCart(itemId);
    
    DialogUtiles.hideDialog(context);
    if (mounted) Navigator.pop(context);

    if (!mounted) return;

    
    setState(() {
      cartData = updatedData; 
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Removed Successfully"), 
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
  } catch (e) {
    if (mounted) Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
    );
  }
}

  @override
  void initState() {
    getcartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final items = cartData?.data?.items ?? [];

    return Scaffold(
      body: Skeletonizer(
        enabled: isLoading,
        child: items.isEmpty 
                ? const Center(child: Text("Nothing to show")) 
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Gap(20),
                          
                          ...items.map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: CardItem(
                              fun: () {
                                if (item.itemId != null) {
                                removeItem(item.itemId!); 
                                }},
                              image: item.image ?? AppAssets.bergar,
                              text: "${item.price ?? 0} EGP" ,
                              title:item.name ?? "Product", 
                            ),
                          )),
                          Gap(130), 
                        ],
                      ),
                    ),
                  ),
      ),
      bottomSheet: Container(
        height: 120,
        color: AppColors.whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Total", style: TextStyle(fontSize: 16)),
                  
                  Text(
                    "${cartData?.data?.totalPrice ?? 0} EGP",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              CustomElvatedButton(
                backGroundColor: AppColors.primaryColor, 
                forGroundColor: AppColors.whiteColor, 
                borderRadius: 15, 
                paddingHorizontal: 30, 
                paddingVertical: 15, 
                text: "Check Out", 
                fun: () => context.push('/CheckoutView',
                            extra: {
                              'price': "${cartData?.data?.totalPrice ?? 0} EGP",
                              
                            },),
                
                textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.whiteColor),
                borderColor: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}