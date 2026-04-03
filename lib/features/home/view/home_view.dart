import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/styling/app_assets.dart';
import 'package:hungry/core/styling/app_colors.dart';
import 'package:hungry/core/widgets/custom_container.dart';
import 'package:hungry/core/widgets/custom_text_field.dart';
import 'package:hungry/core/widgets/dialog_utilies.dart';
import 'package:hungry/features/auth/data/auth_model.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/data/repo/product_repo.dart';
import 'package:hungry/features/home/widgets/card.dart';
import 'package:hungry/network/api_error.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController searchComtroler = TextEditingController();
  List category = ["all","combos","sliders","classic"];
  int selectedIndex = 0;
  ProductRepo productRepo = ProductRepo();
  List<ProductModel>? products;
  List<ProductModel>? allproducts;
  bool isLoading = true;
  final AuthRepo authRepo = AuthRepo();
  AuthModel? authModel;
  Future<void> getProfileData() async {
    try {
      
      final user = await authRepo.getProfileData();

      if (user != null) {
        if (!mounted) return;
        setState(() {
          authModel = user;
          isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      
      String displayMessage = e is ApiError ? e.message : "something went wrong";
      DialogUtiles.showMessage(
        context: context,
        message: displayMessage,
        title: "Error",
        posActionName: "ok",
      );
    }
  }


  Future<void> getProductData() async {
    try {


      final res = await productRepo.getProductData();
      if (!mounted) return;
      setState(() {
        products = res ;
        allproducts = res;
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
    getProductData();
    getProfileData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body:
        Skeletonizer(
          enabled: products == null,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Gap(60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ignore: deprecated_member_use
                          SvgPicture.asset(AppAssets.logo,color: AppColors.primaryColor,width: 40,height: 40,),
                          Text("Hello,${authModel?.name??""}",style: Theme.of(context).textTheme.bodyMedium?.
                          copyWith(color: AppColors.grayColor),)
                        ],
                      ),
                      authModel?.image != null?
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.redColor,width: 2),
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.primaryColor
                        ),child:Center(child: Image.network(authModel?.image??"",)), 
                      )
                      
                      :const CircularProgressIndicator(color: AppColors.primaryColor,), 
                    ],
                  ),
                  Gap(15),
                  Material(
                    elevation: 5.0, 
                    shadowColor: AppColors.blackColor,
                    borderRadius: BorderRadius.circular(10),
                    child: CustomTextField( hint: "search",prefix: Icon(Icons.search,size: 30,
                    color: AppColors.grayColor,),
                    controller:SearchController() ,
                    onChange: (value) {
                      final query = value.toLowerCase();
                      setState(() {
                        products = allproducts?.where((product) {
                          final productName = product.name?.toLowerCase() ?? "";
                          return productName.contains(query);
                        }).toList();
                      });
                    },)),
                    Gap(20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: 
                          List.generate(category.length, (index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: CustomContainer(
                                radius: 15,
                                width: 100,
                                height: 50,
                                color:selectedIndex == index ? 
                                AppColors.primaryColor: AppColors.grayColor,
                                child: 
                                Center(child: Text(category[index],
                                style:selectedIndex == index ? 
                                Theme.of(context).textTheme.bodyMedium?.
                                copyWith(color: AppColors.whiteColor):Theme.of(context).textTheme.bodyMedium?.
                                copyWith(color: AppColors.blackColor))),),
                              ),
                            ) ;
                          })
                        
                      ),
                    ),
                    
                    GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products?.length ?? 0, 
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final product = products![index]; 
                      return InkWell(
                        onTap: () => context.push(
                            '/productView',
                            extra: {
                              'url': product.image,
                              'id': product.id,
                            },
                          ),
                        child: CardItem(
                          image: product.image ?? "", 
                          text: product.description ?? "No Name", 
                          title: product.name ?? "",
                        ),
                      );
                    },
                  ),
          
                    const Gap(20), 
                    
                    
          
          
                        
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}